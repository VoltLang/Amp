/*
  Simple DirectMedia Layer
  Copyright (C) 1997-2018 Sam Lantinga <slouken@libsdl.org>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/
module amp.sdl2.atomic;
extern (C):

/**
 * \file SDL_atomic.h
 *
 * Atomic operations.
 *
 * IMPORTANT:
 * If you are not an expert in concurrent lockless programming, you should
 * only be using the atomic lock and reference counting functions in this
 * file.  In all other cases you should be protecting your data structures
 * with full mutexes.
 *
 * The list of "safe" functions to use are:
 *  SDL_AtomicLock()
 *  SDL_AtomicUnlock()
 *  SDL_AtomicIncRef()
 *  SDL_AtomicDecRef()
 *
 * Seriously, here be dragons!
 * ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 *
 * You can find out a little more about lockless programming and the
 * subtle issues that can arise here:
 * http://msdn.microsoft.com/en-us/library/ee418650%28v=vs.85%29.aspx
 *
 * There's also lots of good information here:
 * http://www.1024cores.net/home/lock-free-algorithms
 * http://preshing.com/
 *
 * These operations may or may not actually be implemented using
 * processor specific atomic operations. When possible they are
 * implemented as true processor specific atomic operations. When that
 * is not possible the are implemented using locks that *do* use the
 * available atomic operations.
 *
 * All of the atomic operations that modify memory are full memory barriers.
 */

import amp.sdl2.stdinc;

/**
 * \name SDL AtomicLock
 *
 * The atomic locks are efficient spinlocks using CPU instructions,
 * but are vulnerable to starvation and can spin forever if a thread
 * holding a lock has been terminated.  For this reason you should
 * minimize the code executed inside an atomic lock and never do
 * expensive things like API or system calls while holding them.
 *
 * The atomic locks are not safe to lock recursively.
 *
 * Porting Note:
 * The spin lock functions and type are required and can not be
 * emulated because they are used in the atomic emulation code.
 */

alias SDL_SpinLock = i32;

/*!
 * Try to lock a spin lock by setting it to a non-zero value.
 *
 * @Param lock Points to the lock.
 *
 * @Returns SDL_TRUE if the lock succeeded, SDL_FALSE if the lock is already held.
 */
fn SDL_AtomicTryLock(lock: SDL_SpinLock*) SDL_bool;

/*!
 * Lock a spin lock by setting it to a non-zero value.
 *
 * @param lock Points to the lock.
 */
fn SDL_AtomicLock(lock: SDL_SpinLock*);

/*!
 * Unlock a spin lock by setting it to 0. Always returns immediately
 *
 * @Param lock Points to the lock.
 */
fn SDL_AtomicUnlock(lock: SDL_SpinLock*);

/*!
 * Prevents the compiler from reordering
 * reads and writes to globally visible variables across the call.
 */
fn SDL_CompilerBarrier()
{
	_tmp: SDL_SpinLock;
	SDL_AtomicLock(&_tmp);
	SDL_AtomicUnlock(&_tmp);
}

/*
 * Memory barriers are designed to prevent reads and writes from being
 * reordered by the compiler and being seen out of order on multi-core CPUs.
 *
 * A typical pattern would be for thread A to write some data and a flag,
 * and for thread B to read the flag and get the data. In this case you
 * would insert a release barrier between writing the data and the flag,
 * guaranteeing that the data write completes no later than the flag is
 * written, and you would insert an acquire barrier between reading the
 * flag and reading the data, to ensure that all the reads associated
 * with the flag have completed.
 *
 * In this pattern you should always see a release barrier paired with
 * an acquire barrier and you should gate the data reads/writes with a
 * single flag variable.
 *
 * For more information on these semantics, take a look at the blog post:
 * http://preshing.com/20120913/acquire-and-release-semantics
 */
fn SDL_MemoryBarrierReleaseFunction();
fn SDL_MemoryBarrierAcquireFunction();

fn SDL_MemoryBarrierRelease()
{
	SDL_CompilerBarrier();
}

fn SDL_MemoryBarrierAcquire()
{
	SDL_CompilerBarrier();
}

/*!
 * A type representing an atomic integer value.
 *
 * It is a struct so people don't accidentally use numeric operations on it.
 */
struct SDL_atomic_t
{
	value: i32;
}

/*!
 * Set an atomic variable to a new value if it is currently an old value.
 *
 * @Returns SDL_TRUE if the atomic variable was set, SDL_FALSE otherwise.
 *
 * If you don't know what this function is for, you shouldn't use it!
*/
fn SDL_AtomicCAS(a: SDL_atomic_t*, oldval: i32, newval: i32) SDL_bool;

/*!
 * Set an atomic variable to a value.
 *
 * @Returns The previous value of the atomic variable.
 */
fn SDL_AtomicSet(a: SDL_atomic_t*, v: i32) i32;

/*!
 * Get the value of an atomic variable
 */
fn SDL_AtomicGet(a: SDL_atomic_t*) i32;

/*!
 * Add to an atomic variable.
 *
 * @Returns The previous value of the atomic variable.
 *
 * This same style can be used for any number of operations.
 */
fn SDL_AtomicAdd(a: SDL_atomic_t*, v: i32) i32;

/*!
 * Increment an atomic variable used as a reference count.
 */
fn SDL_AtomicIncRef(a: SDL_atomic_t*) i32
{
	return SDL_AtomicAdd(a, 1);
}

/*!
 * Decrement an atomic variable used as a reference count.
 *
 * @Returns SDL_TRUE if the variable reached zero after decrementing, SDL_FALSE otherwise.
 */
fn SDL_AtomicDecRef(a: SDL_atomic_t*) SDL_bool
{
	return SDL_AtomicAdd(a, -1) == 1 ? SDL_TRUE : SDL_FALSE;
}

/*!
 * Set a pointer to a new value if it is currently an old value.
 *
 * @Returns SDL_TRUE if the pointer was set, SDL_FALSE otherwise.
 *
 * If you don't know what this function is for, you shouldn't use it!
*/
fn SDL_AtomicCASPtr(a: void**, oldval: void*, newval: void*) SDL_bool;

/*!
 * Set a pointer to a value atomically.
 *
 * @Returns The previous value of the pointer.
 */
fn SDL_AtomicSetPtr(a: void**, v: void*) void*;

/*!
 * Get the value of a pointer atomically.
 */
fn SDL_AtomicGetPtr(a: void**) void*;
