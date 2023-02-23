import asyncio
from dataclasses import dataclass
from datetime import datetime
from typing import Any, Awaitable, Generator, Generic, Self, TypeVar
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
        print(f"├── calling @{now()} _make_cancelled_error() on {self}[@{id(self)}]")
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
        print(f"├── calling @{now()} __schedule_callbacks() on {self}[@{id(self)}]")
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
        print(f"├── calling @{now()} add_done_callback(fn={fn}, *args={args}, context={context}) on {self}[@{id(self)}]")
        try:
            result = self.future.add_done_callback(fn, *args, context=context)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def remove_done_callback(self: Self, fn):
        print(f"├── calling @{now()} remove_done_callback(fn={fn}) on {self}[@{id(self)}]")
        try:
            result = self.future.remove_done_callback(fn)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def set_result(self: Self, result):
        print(f"├── calling @{now()} set_result(result={result}) on {self}[@{id(self)}]")
        try:
            result = self.future.set_result(result)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def set_exception(self: Self, exception):
        print(f"├── calling @{now()} set_exception(exception={exception}) on {self}[@{id(self)}]")
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

    def __next__(self: Self) -> T:
        print(f"├── calling @{now()} __next__() on {self}[@{id(self)}]")
        try:
            result = self.generator.__next__()
            if isinstance(result, asyncio.Future):
                print("│   ├── converts result to FutureWrapper")
                result = FutureWrapper(result)
            print(f"│   ├── returns {result}")
            # print(f"│   └── with dir() = {dir(result)}")
            return result
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
        print(f"├── calling @{now()} send(value={value}) on {self}[@{id(self)}]")
        try:
            result = self.generator.send(value)
            print(f"│   └── returns {result}")
            return result
        except BaseException as e:
            print(f"│   └── raised Exception: {e}")
            raise

    def throw(self: Self, typ, val=None, tb=None) -> T:
        print(f"├── calling @{now()} throw(typ={typ}, val={val}, tb={tb}) on {self}[@{id(self)}]")
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

if __name__ == "__main__":
    print("starting asyncio.run")
    asyncio.run(my_coroutine(my_awaitable()))
    print("└── completed asyncion.run")
