import asyncio
from dataclasses import dataclass, field
from datetime import datetime
import types
from typing import Any, Awaitable, Generator, Generic, Optional, Self, TypeVar
import time


T = TypeVar("T")
T_Send = TypeVar("T_Send")
T_Return = TypeVar("T_Return")


def now() -> str:
    return datetime.utcfromtimestamp(time.time()).strftime('%H:%M:%S.%f')


@dataclass
class FutureWrapper(asyncio.Future):
    future: asyncio.Future

    def __del__(self: Self):
        self.future.__del__()

    @property
    def _asyncio_future_blocking(self) -> Any:
        result = self.future._asyncio_future_blocking
        print(
            f"├── reading @{now()} _asyncio_future_blocking on {self}[@{id(self)}]")
        print(f"│   └── returns {result}")
        return result

    @_asyncio_future_blocking.setter
    def _asyncio_future_blocking(self, val):
        print(
            f"├── setting @{now()} _asyncio_future_blocking on {self}[@{id(self)}]")
        print(f"│   └── to {val}")
        self.future._asyncio_future_blocking = val

    @property
    def _log_traceback(self):
        return self.future._log_traceback

    @_log_traceback.setter
    def _log_traceback(self, val):
        self.future._log_traceback = val

    def get_loop(self: Self):
        print(f"├── calling @{now()} get_loop() on {self}[@{id(self)}]")
        try:
            result = self.future.get_loop()
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def _make_cancelled_error(self: Self):
        print(
            f"├── calling @{now()} _make_cancelled_error() on {self}[@{id(self)}]")
        try:
            result = self.future._make_cancelled_error()
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def cancel(self: Self, msg=None):
        print(f"├── calling @{now()} cancel(msg={msg}) on {self}[@{id(self)}]")
        try:
            result = self.future.cancel(msg)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def __schedule_callbacks(self: Self):
        print(
            f"├── calling @{now()} __schedule_callbacks() on {self}[@{id(self)}]")
        try:
            result = self.future.__schedule_callbacks()
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def cancelled(self: Self):
        print(f"├── calling @{now()} cancelled() on {self}[@{id(self)}]")
        try:
            result = self.future.cancelled()
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def done(self: Self):
        print(f"├── calling @{now()} done() on {self}[@{id(self)}]")
        try:
            result = self.future.done()
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def result(self: Self):
        print(f"├── calling @{now()} result() on {self}[@{id(self)}]")
        try:
            result = self.future.result()
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def exception(self: Self):
        print(f"├── calling @{now()} exception() on {self}[@{id(self)}]")
        try:
            result = self.future.exception()
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def add_done_callback(self: Self, fn, *args, context=None):
        print(
            f"├── calling @{now()} add_done_callback(fn={fn}, *args={args}, context={context}) on {self}[@{id(self)}]")
        try:
            result = self.future.add_done_callback(fn, *args, context=context)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def remove_done_callback(self: Self, fn):
        print(
            f"├── calling @{now()} remove_done_callback(fn={fn}) on {self}[@{id(self)}]")
        try:
            result = self.future.remove_done_callback(fn)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def set_result(self: Self, result):
        print(
            f"├── calling @{now()} set_result(result={result}) on {self}[@{id(self)}]")
        try:
            result = self.future.set_result(result)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def set_exception(self: Self, exception):
        print(
            f"├── calling @{now()} set_exception(exception={exception}) on {self}[@{id(self)}]")
        try:
            result = self.future.set_exception(exception)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def __await__(self: Self):
        print(f"├── calling @{now()} __await__() on {self}[@{id(self)}]")
        try:
            result = self.future.__await__()
            result = GeneratorWrapper(result)
            print(f"│   └── returns {result}")
            return result
        except RuntimeError as exc:
            if len(exc.args) > 0 and exc.args[0] == "await wasn't used with future":
                raise Exception("bogus 1")
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def __iter__(self: Self):
        print(f"├── calling @{now()} __iter__() on {self}[@{id(self)}]")
        try:
            result = self.future.__iter__()
            result = GeneratorWrapper(result)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise


@dataclass
class GeneratorWrapper(Generic[T, T_Send, T_Return], Generator[T, T_Send, T_Return]):
    generator: Generator[T, T_Send, T_Return]
    __simulated_yield_froms: list[Generator[T, T_Send, T_Return]] = field(
        init=False, default_factory=list)

    def __simulate_yield_from_next(self: Self) -> tuple[bool, T]:
        print(
            f"│   ├── trying to simulate yield from, with a backlog of length {len(self.__simulated_yield_froms)}")
        while len(self.__simulated_yield_froms) > 0:
            try:
                result = (True, self.__simulated_yield_froms[-1].__next__())
                print(
                    f"│   │   └── simulating yield from by returning {result}")
                return result
            except StopIteration:
                print(
                    f"│   │   └── simulating yield from raised StopIteration")
                self.__simulated_yield_froms = self.__simulated_yield_froms[:-1]
        print(f"│   │   └── nothing to yield, stopping simulation")
        return False, None

    def __next__(self: Self) -> T:
        print(f"├── calling @{now()} __next__() on {self}[@{id(self)}]")
        try:
            # simulate any outstanding yield from first
            s, r = self.__simulate_yield_from_next()
            if s:
                return r

            # run own next
            result = self.generator.__next__()
            if isinstance(result, asyncio.Future):
                print("│   ├── converts result to FutureWrapper")
                result = FutureWrapper(result)
                print(
                    f"│   ├── needs to simulate 'yield from' on that FutureWrapper, returning a GeneratorWrapper(FutureWrapper)")
                self.__simulated_yield_froms.append(
                    GeneratorWrapper(result.__iter__()))
                s, r = self.__simulate_yield_from_next()
                if s:
                    return r

            print(f"│   └── returns {result}")
            # print(f"│   └── with dir() = {dir(result)}")
            return result
        except RuntimeError as exc:
            if len(exc.args) > 0 and exc.args[0] == "await wasn't used with future":
                raise Exception("bogus 2")
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def __iter__(self: Self) -> Generator[T, T_Send, T_Return]:
        print(f"├── calling @{now()} __iter__() on {self}[@{id(self)}]")
        try:
            result = self
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def send(self: Self, value: T_Send) -> T:
        print(
            f"├── calling @{now()} send(value={value}) on {self}[@{id(self)}]")
        try:
            result = self.generator.send(value)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def throw(self: Self, typ, val=None, tb=None) -> T:
        print(
            f"├── calling @{now()} throw(typ={typ}, val={val}, tb={tb}) on {self}[@{id(self)}]")
        try:
            result = self.generator.throw(typ)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def close(self: Self):
        print(f"├── calling @{now()} close() on {self}[@{id(self)}]")
        try:
            self.generator.close()
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise


@dataclass
class AwaitableWrapper(Generic[T], Awaitable[T]):
    awaitable: Awaitable[T]

    def __await__(self: Self) -> GeneratorWrapper[Any, None, T]:
        print(f"├── calling @{now()} __await__() on {self}[@{id(self)}]")
        try:
            result = GeneratorWrapper(self.awaitable.__await__())
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise


async def my_awaitable() -> int:
    await asyncio.sleep(1)
    return 1


async def my_coroutine(awaitable: Awaitable) -> int:
    wrapped_awaitable = AwaitableWrapper(awaitable)
    result = await wrapped_awaitable
    return result


@dataclass
class MySleep:
    seconds: float
    __start: float = field(init=False, default=time.time())
    __count: int = field(init=False, default=0)

    _asyncio_future_blocking = True

    def __await__(self: Self) -> Generator[float, None, None]:
        print(f"called __await__ {self.__count} times already @{now()}")
        self.__count += 1
        diff = time.time() - self.__start
        if diff < self.seconds:
            yield self
        return diff


@dataclass
class MySleepAgain:
    seconds: float
    __start: float = field(init=False, default=time.time())
    __count: int = field(init=False, default=0)

    def __await__(self: Self) -> Generator[Any, None, None]:
        coro = asyncio.sleep(self.seconds)
        coro_it = coro.__await__()
        print(
            f"got coro.__await__() of type {type(coro_it)} w/ value: {coro_it}")
        try:
            while True:
                e = next(coro_it)
                print(
                    f"called next on __await__-result, yielding {e}[{id(e)}] @{now()}")
                print(dir(e))
                e__await__ = e.__await__()
                print(
                    f"calling __await__ on yielding value returns {e__await__}[{id(e__await__)}] @{now()}")
                e__await__it = iter(e__await__)
                print(
                    f"got e__await__it.__iter__() of type {type(e__await__it)} w/ value: {e__await__it}[{id(e__await__it)}] @{now()}")
                print(dir(e__await__it))
                print(f"send @{id(e__await__it.send)}")
                print(f"__next__ @{id(e__await__it.__next__)}")
                # e.set_result(None)
                e_prime = e__await__it.send(None)
                print(f"could yield instead {e_prime}[{id(e_prime)}] @{now()}")
                yield e
        except StopIteration:
            pass
        except Exception as exc:
            print(f"got exception({type(exc)}): {exc}")


@dataclass
class MySleepAgain2:
    seconds: float
    __start: float = field(init=False, default=time.time())
    __count: int = field(init=False, default=0)

    def __await__(self: Self) -> Generator[Any, None, None]:
        async def inner():
            await asyncio.sleep(1)
        # Phase 1
        # typical: pass-through
        # return inner().__await__()

        # Phase 2
        # old-style: yield from
        # yield from inner().__await__()

        # Phase 3
        # low-level: loop yield
        """
        it = inner().__await__()
        try:
            while True:
                e = next(it)
                yield e
        except StopIteration:
            pass
        """

        # Phase 4
        # using __next__
        """
        it = inner().__await__()
        try:
            while True:
                e = it.__next__()
                yield e
        except StopIteration:
            pass
        """

        # Phase 5
        # adding counters
        it = inner().__await__()
        try:
            c = 0
            while True:
                e = it.__next__()
                c += 1
                is_future = isinstance(e, asyncio.Future)
                print(
                    f"called __next__() {c} times, yielding {type(e)} which is a future? {is_future}")
                if is_future:
                    print("wrapping future")
                    e = FutureWrapper(e)
                yield e
        except StopIteration:
            pass


@dataclass
class MyAwaitable:
    def __await__(self: Self):
        result = yield None
        print(f"first yield: {result} @{now()}")
        result = yield None
        print(f"second yield: {result} @{now()}")
        result = yield None
        print(f"third yield: {result} @{now()}")
        return 0


@dataclass
class MySleepAgain3:
    seconds: int

    def __await__(self: Self):
        start = time.time()
        i = 0
        end = time.time()
        while end - start < self.seconds:
            result = yield None
            print(f"yield #0: {result} @{now()}")
            end = time.time()
        return end - start


def main1():
    print("starting asyncio.run on main1")
    asyncio.run(my_coroutine(my_awaitable()))
    print("└── completed asyncion.run")


async def amain2(awaitable: Awaitable[float]):
    result = await awaitable
    print(f"Awaited result: {result}")


def main2():
    print("Starting asyncio.run on main2")
    asyncio.run(amain2(MySleep(1)))
    print("└── completed asyncion.run")


def main3():
    ma1 = my_awaitable()
    print(id(ma1))
    ma2 = ma1.__await__()
    print(id(ma2))
    ma3 = ma2.__iter__()
    print(id(ma3))

    loop = asyncio.events.new_event_loop()
    asyncio.events.set_event_loop(loop)
    asyncio.events._set_running_loop(loop)
    """with asyncio.Runner(debug=True) as runner:
        runner.run(main)
        runner.get_loop()"""
    ma4 = ma3.__next__()
    print(id(ma4), type(ma4))
    print(dir(ma4))
    ma5 = ma4.get_loop()
    print(id(ma5), type(ma5))
    print(dir(ma5))


async def amain4(awaitable: Awaitable[float]):
    result = await awaitable
    print(f"Awaited result: {result}")


def main4():
    print("Starting asyncio.run on main4")
    asyncio.run(amain4(MySleepAgain(1)))
    print("└── completed asyncion.run")


async def amain5(awaitable: Awaitable[float]):
    result = await awaitable
    print(f"Awaited result: {result}")


def main5():
    print("Starting asyncio.run on main5")
    asyncio.run(amain5(MySleepAgain2(1)))
    print("└── completed asyncion.run")


def main6():
    loop = asyncio.get_event_loop()
    future = loop.create_future()


async def amain7():
    result = await MyAwaitable()
    print(f"my awaitable returned: {result} @{now()}")


def main7():
    print("starting asyncio.run on main7")
    asyncio.run(amain7())
    print("└── completed asyncion.run")


async def amain8():
    result = await MySleepAgain3(1)
    print(f"my sleep again 3 returned: {result} @{now()}")


def main8():
    print("starting asyncio.run on main8")
    asyncio.run(amain8())
    print("└── completed asyncion.run")


async def my_await(awaitable: Awaitable):
    print(f"awaitable: {awaitable} @{id(awaitable)} [{dir(awaitable)}]")
    iterable = awaitable.__await__()
    print(f"iterable: {iterable} @{id(iterable)} [{dir(iterable)}]")
    iterator = iter(iterable)
    print(f"iterator: {iterator} @{id(iterator)} [{dir(iterator)}]")
    while True:
        try:
            x = next(iterator)
            print(f"x: {x} @{id(x)} [{dir(x)}]")
            if hasattr(x, "__await__"):
                await x
            await asyncio.sleep(0.1)
        except StopIteration as e:
            return e.value


async def amain9():
    awaitable = asyncio.sleep(1)
    result = await my_await(awaitable)
    print(f"my awaitable returned: {result} @{now()}")
    return result


def main9():
    print("starting asyncio.run on main9")
    asyncio.run(amain9())
    print("└── completed asyncion.run")


if __name__ == "__main__":
    # main1()
    # main2()
    # main3()
    # main4()
    # main5()
    # main6()
    # main7()
    # main8()
    main9()
    pass
