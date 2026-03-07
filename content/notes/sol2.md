---
tags:
  - language/lua
  - just-in-time
  - translation
---

_lua_

---

[원문](https://sol2.readthedocs.io/en/latest/tutorial/all-the-things.html)

---

# tutorial: quick 'n' dirty (빠르고 간단한 튜토리얼)

이것이 모든 것입니다. 브라우저의 검색 기능을 사용하여 원하는 것을 찾으세요.

**참고**: sol의 기본을 배운 후에는, 어떤 것이 작동할 것 같으면 시도해 보는 것이 좋습니다. 아마 작동할 것입니다!

**참고**: 아래의 모든 코드는 [sol3 튜토리얼 예제](https://github.com/ThePhD/sol2/tree/develop/examples/source/tutorials/quick_n_dirty)에서 확인할 수 있습니다.

**참고**: 안전성을 켜려면 빌드 구성에 `SOL_ALL_SAFETIES_ON` 전처리기 정의를 추가하세요.

---

## asserts / prerequisites (전제 조건)

코드 어딘가에 `#include <sol/sol.hpp>`를 추가해야 합니다. sol은 헤더 전용이므로 아무것도 컴파일할 필요가 없습니다. 그러나 **Lua는 컴파일되고 사용 가능해야 합니다**. 자세한 내용은 [시작하기 튜토리얼](https://sol2.readthedocs.io/en/latest/tutorial/getting-started.html)을 참조하세요.

`c_assert`가 포함된 `assert.hpp`의 구현은 다음과 같습니다:

```cpp
#ifndef EXAMPLES_ASSERT_HPP
#define EXAMPLES_ASSERT_HPP

#   define m_assert(condition, message) \
    do { \
        if (! (condition)) { \
            std::cerr << "Assertion `" #condition "` failed in " << __FILE__ \
                      << " line " << __LINE__ << ": " << message << std::endl; \
            std::terminate(); \
        } \
    } while (false)

#   define c_assert(condition) \
    do { \
        if (! (condition)) { \
            std::cerr << "Assertion `" #condition "` failed in " << __FILE__ \
                      << " line " << __LINE__ << std::endl; \
            std::terminate(); \
        } \
    } while (false)
#else
#   define m_assert(condition, message) do { if (false) { (void)(condition); (void)sizeof(message); } } while (false)
#   define c_assert(condition) do { if (false) { (void)(condition); } } while (false)
#endif

#endif // EXAMPLES_ASSERT_HPP
```

이것이 아래의 빠른 코드에서 사용되는 assert입니다.

---

## opening a state (상태 열기)

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>
#include <assert.hpp>

int main(int, char*[]) {
	std::cout << "=== opening a state ===" << std::endl;

	sol::state lua;
	// 일반적인 라이브러리 열기
	lua.open_libraries(sol::lib::base, sol::lib::package);
	lua.script("print('bark bark bark!')");

	std::cout << std::endl;

	return 0;
}
```

---

## using sol3 on a lua_State* (lua_State*에서 sol3 사용하기)

이미 Lua를 가지고 있거나 자체 제작 또는 기존 Lua 시스템(LuaBridge, kaguya, Luwra 등)을 사용하는 시스템/게임이 있지만 여전히 sol3와 좋은 기능을 원하는 경우:

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>

int use_sol2(lua_State* L) {
	sol::state_view lua(L);
	lua.script("print('bark bark bark!')");
	return 0;
}

int main(int, char*[]) {
	std::cout << "=== opening sol::state_view on raw Lua ===" << std::endl;

	lua_State* L = luaL_newstate();
	luaL_openlibs(L);

	lua_pushcclosure(L, &use_sol2, 0);
	lua_setglobal(L, "use_sol2");

	if (luaL_dostring(L, "use_sol2()")) {
		lua_error(L);
		return -1;
	}

	std::cout << std::endl;

	return 0;
}
```

---

## running lua code (Lua 코드 실행하기)

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <fstream>
#include <iostream>
#include <assert.hpp>

int main(int, char*[]) {
	std::cout << "=== running lua code ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);
	
	// 문자열에서 로드하고 실행
	lua.script("a = 'test'");
	// 파일에서 로드하고 실행
	lua.script_file("a_lua_script.lua");

	// 스크립트 실행하고 결과 얻기
	int value = lua.script("return 54");
	c_assert(value == 54);
```

문제가 발생했을 때 에러 핸들러를 사용하여 Lua 코드를 실행하려면:

```cpp
	auto bad_code_result = lua.script("123 herp.derp", [](lua_State*, sol::protected_function_result pfr) {
		// pfr에는 스크립트 로딩 또는 실행 중 잘못된 내용이 포함됩니다
		// 사용자 정의 에러를 던질 수 있습니다
		// 또는 그냥 반환하여 호출 사이트에서 에러를 처리하도록 할 수 있습니다
		return pfr;
	});
	// 작동하지 않았습니다
	c_assert(!bad_code_result.valid());
	
	// 기본 핸들러는 설정에 따라 패닉하거나 던집니다
	// 폭발을 원하면 주석을 해제하세요:
	//auto bad_code_result_2 = lua.script("bad.code", &sol::script_default_on_error);
	return 0;
}
```

`.safe_script`를 사용하여 안전성을 더 활용할 수 있습니다. 이는 에러와 유사한 것을 적절히 확인하는 데 사용할 수 있는 보호된 결과를 반환합니다.

**참고**: 안전성 정의가 켜져 있으면 `.script`는 자동으로 `.safe_script` 버전을 호출합니다. 그렇지 않으면 `.unsafe_script` 버전을 호출합니다.

---

## running lua code (low-level) (Lua 코드 실행하기 - 저수준)

개별 load와 함수 호출 연산자를 사용하여 코드를 로드하고, 확인한 다음, 실행하고 확인할 수 있습니다.

**경고**: 이것은 세밀한 제어가 필요한 경우에만 사용합니다. 99%의 경우 [Lua 코드 실행하기](https://claude.ai/chat/dc0152d5-3b57-4fdc-b10b-260edad81c46#running-lua-code)가 선호되며 script/load의 차이점을 이해하지 못하고 로드 후 청크를 실행해야 하는 함정을 피할 수 있습니다.

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <fstream>
#include <iostream>
#include <cstdio>
#include <assert.hpp>

int main(int, char*[]) {
	std::cout << "=== running lua code (low level) ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);

	// 실행하지 않고 파일 로드
	sol::load_result script1 = lua.load_file("a_lua_script.lua");
	// 실행
	script1();

	// 실행하지 않고 문자열 로드
	sol::load_result script2 = lua.load("a = 'test'");
	// 실행
	sol::protected_function_result script2result = script2();
	// 선택적으로, 작동했는지 확인
	if (script2result.valid()) {
		// 좋아요!
	}
	else {
		// 아쉽게도
	}

	sol::load_result script3 = lua.load("return 24");
	// 실행하고 반환 값 얻기
	int value2 = script3();
	c_assert(value2 == 24);

	return 0;
}
```

문자열이나 파일이 아닌 것에서 가져오는 사용자 정의 로더를 개발할 수도 있습니다.

Lua 스크립트에 인수를 전달하려면 먼저 파일이나 스크립트 블록을 로드한 다음 sol의 추상화를 사용하여 호출합니다. 그런 다음 스크립트에서 할당문의 왼쪽에 `...`를 사용하여 변수에 액세스합니다:

---

## passing arguments to scripts (스크립트에 인수 전달하기)

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>
#include <assert.hpp>

int main(int, char* []) {
	std::cout << "=== passing arguments to scripts ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);

	const auto& my_script = R"(
local a,b,c = ...
print(a,b,c)
	)";

	sol::load_result fx = lua.load(my_script);
	if (!fx.valid()) {
		sol::error err = fx;
		std::cerr << "failed to load string-based script into the program" << err.what() << std::endl;
	}
	
	// "your arguments here" 출력
	fx("your", "arguments", "here");

	return 0;
}
```

---

## transferring functions / dumping bytecode (함수 전송 / 바이트코드 덤프)

함수의 바이트코드를 덤프하여 다른 state로 전송하거나(또는 저장하거나 로드) 할 수 있습니다. 바이트코드는 일반적으로 Lua 버전에 특정합니다!

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>
#include <cstdio>
#include <cassert>

int main(int, char* []) {
	std::cout << "=== transferring functions / dumping bytecode ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);

	sol::bytecode bc = lua.script(R"(
return function (a, b, c)
	return a * b + c
end
	)").dump();

	sol::state lua2;
	lua2.open_libraries(sol::lib::base);

	sol::protected_function pf = lua2.load(bc.as_string_view());
	int value = pf(10, 10, 7);
	assert(value == 107);

	std::cout << std::endl;

	return 0;
}
```

---

## set and get variables (변수 설정 및 가져오기)

테이블과 유사한 구문을 사용하여 모든 것을 설정/가져올 수 있습니다.

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>
#include <assert.hpp>

int main(int, char*[]) {
	std::cout << "=== set_get ===" << std::endl;

	sol::state lua;

	// 전역 변수 설정
	lua["var"] = 5;
	lua["var2"] = "apple";

	// set과 get도 동일하게 동작합니다.
	lua.set("var3", 5);
	lua.set("var4", "apple");

	int var = lua["var"];
	std::string var2 = lua["var2"];
	int var3 = lua.get<int>("var3");
	std::string var4 = lua.get<std::string>("var4");

	c_assert(var == 5);
	c_assert(var2 == "apple");
	c_assert(var3 == 5);
	c_assert(var4 == "apple");

	// get_or는 변수가 존재하지 않을 때 기본값을 반환합니다
	int var5 = lua.get_or("var5", 10);
	c_assert(var5 == 10);

	std::cout << std::endl;

	return 0;
}
```

sol 타입과 다른 타입을 사용하여 Lua 타입을 검색합니다.

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>
#include <string>
#include <assert.hpp>

int main(int, char*[]) {
	std::cout << "=== retrieve types ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);

	lua.script(R"(
boolf = false
numi = 1
numf = 2.4
str = 'a string'
nilval = nil
	)");

	bool boolf = lua["boolf"];
	int numi = lua["numi"];
	double numf = lua["numf"];
	std::string str = lua["str"];

	// nil 검색
	sol::lua_nil_t nilval = lua["nilval"];
	// 지정할 필요가 없습니다
	sol::lua_nil_t nilval2 = lua["nilval"];

	c_assert(boolf == false);
	c_assert(numi == 1);
	c_assert(numf == 2.4);
	c_assert(str == "a string");
	c_assert(nilval == sol::lua_nil);
	c_assert(nilval2 == sol::lua_nil);

	std::cout << std::endl;

	return 0;
}
```

nullptr 또는 sol::lua_nil로 설정하여 항목을 지울 수 있습니다. C++ 타입의 userdata/usertype인 경우, 가비지 수집기가 메모리를 파괴하는 것이 적절하다고 판단할 때만 소멸자가 실행됩니다. sol::lua_nil로 설정될 때 소멸자가 실행되는 것에 의존하고 있다면 아마도 실수를 하고 있는 것입니다.

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>
#include <string>
#include <assert.hpp>

int main() {
	std::cout << "=== erase ===" << std::endl;

	sol::state lua;

	lua["var"] = 5;
	c_assert(lua["var"].valid());

	// lua에서 삭제
	lua["var"] = sol::lua_nil;
	c_assert(!lua["var"].valid());

	std::cout << std::endl;

	return 0;
}
```

---

## tables (테이블)

테이블은 접근자 구문을 사용하여 조작할 수 있습니다. sol::state도 테이블이며 여기에 표시된 모든 메서드는 sol::state에서도 작동합니다.

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>
#include <assert.hpp>

int main() {
	std::cout << "=== tables ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);

	// Lua 테이블 생성
	lua.script("arr = { 1, 2, 3, 4, 5 }");
	
	// 테이블 가져오기
	sol::table arr = lua["arr"];
	
	// 첫 번째 요소 가져오기 (Lua는 1부터 시작)
	int first = arr[1];
	c_assert(first == 1);

	// 루프
	for (auto key_value_pair : arr) {
		sol::object key = key_value_pair.first;
		sol::object value = key_value_pair.second;
		std::cout << "key: " << key.as<int>() << ", value: " << value.as<int>() << std::endl;
	}

	std::cout << std::endl;

	return 0;
}
```

---

## make tables (테이블 만들기)

테이블을 만드는 방법은 여러 가지가 있습니다. 간단한 것을 위한 쉬운 방법은 다음과 같습니다:

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>
#include <assert.hpp>

int main() {
	std::cout << "=== make tables ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);

	// 빈 테이블 생성
	sol::table tbl = lua.create_table();
	tbl["key"] = "value";

	// 초기 값으로 테이블 생성
	sol::table tbl2 = lua.create_table_with(
		"key", "value",
		"another_key", 24,
		"final_key", sol::lua_nil
	);

	c_assert(tbl["key"] == "value");
	c_assert(tbl2["key"] == "value");
	c_assert(tbl2["another_key"] == 24);
	c_assert(!tbl2["final_key"].valid());

	std::cout << std::endl;

	return 0;
}
```

동등한 Lua 코드는 다음과 같으며 동등한지 확인합니다:

```lua
tbl = {}
tbl.key = "value"

tbl2 = {
	key = "value",
	another_key = 24,
	final_key = nil
}
```

문자열, 숫자, 함수, 다른 테이블을 포함하여 원하는 모든 것을 테이블에 값이나 키로 넣을 수 있습니다. 이런 것들이 중첩될 수 있다는 아이디어는 중요하며 나중에 네임스페이싱을 할 때 도움이 될 것입니다.

---

## functions (함수)

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>
#include <assert.hpp>

int main() {
	std::cout << "=== functions ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);

	// C++ 함수 바인딩
	lua["add"] = [](int a, int b) { return a + b; };
	
	// Lua에서 호출
	lua.script("result = add(2, 3)");
	int result = lua["result"];
	c_assert(result == 5);

	// Lua 함수 가져오기
	lua.script("function multiply(a, b) return a * b end");
	sol::function multiply = lua["multiply"];
	int product = multiply(3, 4);
	c_assert(product == 12);

	std::cout << std::endl;

	return 0;
}
```

에러와 파서 문제로부터 보호하고 Lua의 longjmp 문제를 다룰 준비가 되지 않았다면(C로 컴파일한 경우) sol::protected_function을 사용하세요.

멤버 변수를 함수로 바인딩할 수도 있으며, 모든 종류의 함수와 같은 것들도 바인딩할 수 있습니다:

```cpp
struct my_class {
	int value = 10;
	
	int get_value() const { return value; }
	void set_value(int v) { value = v; }
};

sol::state lua;
lua.new_usertype<my_class>("my_class",
	"value", &my_class::value,
	"get", &my_class::get_value,
	"set", &my_class::set_value
);
```

`sol::readonly(&some_class::variable)`를 사용하여 변수를 읽기 전용으로 만들고 누군가 쓰기를 시도하면 에러를 발생시킬 수 있습니다.

---

## self call (자기 호출)

멤버 함수를 Lua의 `:` 구문으로 호출할 수 있습니다:

```cpp
struct dog {
	std::string name = "unnamed";
	
	void bark() {
		std::cout << name << " says woof!" << std::endl;
	}
};

sol::state lua;
lua.new_usertype<dog>("dog",
	"name", &dog::name,
	"bark", &dog::bark
);

lua.script(R"(
	d = dog.new()
	d.name = "Fido"
	d:bark()  -- Fido says woof!
)");
```

---

## multiple returns from Lua (Lua에서 여러 반환 값)

Lua에서 여러 값을 반환받으려면:

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <tuple>
#include <iostream>
#include <assert.hpp>

int main() {
	std::cout << "=== multiple returns from Lua ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);

	lua.script("function f(a, b, c) return a, b, c end");

	// std::tuple로 받기
	std::tuple<int, int, std::string> result = lua["f"](100, 200, "hello);
	c_assert(std::get<0>(result) == 100);
	c_assert(std::get<1>(result) == 200);
	c_assert(std::get<2>(result) == "hello");

	// sol::tie로 개별 변수에 받기
	int a, b;
	std::string c;
	sol::tie(a, b, c) = lua["f"](100, 200, "world);
	c_assert(a == 100);
	c_assert(b == 200);
	c_assert(c == "world");

	std::cout << std::endl;

	return 0;
}
```

---

## multiple returns to Lua (Lua로 여러 반환 값)

C++에서 여러 값을 Lua로 반환하려면:

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <tuple>
#include <iostream>
#include <assert.hpp>

int main() {
	std::cout << "=== multiple returns to Lua ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);

	// std::tuple 반환
	lua["f"] = []() {
		return std::make_tuple(1, 2, "hello");
	};

	lua.script(R"(
		a, b, c = f()
		assert(a == 1)
		assert(b == 2)
		assert(c == "hello")
	)");

	std::cout << std::endl;

	return 0;
}
```

---

## C++ classes from C++ (C++에서 C++ 클래스)

다음이 아닌 모든 것:

- 기본 타입: bool, char/short/int/long/long long, float/double
- 문자열 타입: std::string, const char*
- 함수 타입: 함수 포인터, lua_CFunction, std::function, sol::function/sol::protected_function, sol::coroutine, 멤버 변수, 멤버 함수
- 지정된 sol 타입: sol::table, sol::thread, sol::error, sol::object
- 투명한 인수 타입: sol::variadic_arg, sol::this_state, sol::this_environment
- usertype<T> 클래스: sol::usertype

은 userdata + usertype으로 설정됩니다.

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <assert.hpp>
#include <iostream>

struct Doge {
	int tailwag = 50;

	Doge() {
	}

	Doge(int wags)
	: tailwag(wags) {
	}

	~Doge() {
		std::cout << "Dog at " << this << " is being destroyed..." << std::endl;
	}
};

int main(int, char* []) {
	std::cout << "=== userdata ===" << std::endl;

	sol::state lua;

	Doge dog{ 30 };

	// Lua에 새로운 것을 넣음
	lua["dog"] = Doge{};
	// Lua로 복사: 가비지 수집 중에 Lua VM에 의해 파괴됨
	lua["dog_copy"] = dog;
	// 또는: 이동 의미론 - 존재하는 경우 이동 생성자를 호출
	// 다시 말하지만, Lua가 소유
	lua["dog_move"] = std::move(dog);
	lua["dog_unique_ptr"] = std::make_unique<Doge>(25);
	lua["dog_shared_ptr"] = std::make_shared<Doge>(31);

	// 위와 동일
	Doge dog2{ 30 };
	lua.set("dog2", Doge{});
	lua.set("dog2_copy", dog2);
	lua.set("dog2_move", std::move(dog2));
	lua.set("dog2_unique_ptr", std::unique_ptr<Doge>(new Doge(25)));
	lua.set("dog2_shared_ptr", std::shared_ptr<Doge>(new Doge(31)));

	// 모두 같은 방식으로 검색할 수 있습니다:
	Doge& lua_dog = lua["dog"];
	Doge& lua_dog_copy = lua["dog_copy"];
	Doge& lua_dog_move = lua["dog_move"];
	Doge& lua_dog_unique_ptr = lua["dog_unique_ptr"];
	Doge& lua_dog_shared_ptr = lua["dog_shared_ptr"];
	c_assert(lua_dog.tailwag == 50);
	c_assert(lua_dog_copy.tailwag == 30);
	c_assert(lua_dog_move.tailwag == 30);
	c_assert(lua_dog_unique_ptr.tailwag == 25);
	c_assert(lua_dog_shared_ptr.tailwag == 31);
	std::cout << std::endl;

	return 0;
}
```

std::unique_ptr/std::shared_ptr의 참조 카운트 / 삭제자는 존중됩니다.

C++에서 Lua에서 사용되는/존재하는 동안 메모리가 죽지 않을 것을 알고 있는 것을 참조하려면 다음을 수행하세요:

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <assert.hpp>
#include <iostream>

struct Doge {
	int tailwag = 50;

	Doge() {
	}

	Doge(int wags)
		: tailwag(wags) {
	}

	~Doge() {
		std::cout << "Dog at " << this << " is being destroyed..." << std::endl;
	}
};

int main(int, char* []) {
	std::cout << "=== userdata memory reference ===" << std::endl;

	sol::state lua;
	lua.open_libraries(sol::lib::base);

	Doge dog{}; // 어떻게든 살아있게 유지됨

	// 나중에...
	// 다음은 참조를 저장하고 복사/이동하지 않습니다
	// 수명은 C++의 dog와 동일합니다
	// (파괴된 후 액세스하는 것은 나쁩니다)
	lua["dog"] = &dog;
	// 위와 동일: std::reference_wrapper를 존중합니다
	lua["dog"] = std::ref(dog);
	// 이 두 개는 위와 동일합니다
	lua.set( "dog", &dog );
	lua.set( "dog", std::ref( dog ) );


	Doge& dog_ref = lua["dog"]; // Lua 메모리 참조
	Doge* dog_pointer = lua["dog"]; // Lua 메모리 참조
	Doge dog_copy = lua["dog"]; // 복사, lua에 영향을 주지 않음
```

userdata를 다른 모든 것과 같은 방식으로 검색할 수 있습니다. 중요한 점은 포인터나 참조를 얻으면 usertype 변수의 데이터를 변경할 수 있고 lua의 것에 영향을 준다는 것입니다:

```cpp
	lua.new_usertype<Doge>("Doge",
		"tailwag", &Doge::tailwag
	);

	dog_copy.tailwag = 525;
	// 여전히 50
	lua.script("assert(dog.tailwag == 50)");

	dog_ref.tailwag = 100;
	// 이제 100
	lua.script("assert(dog.tailwag == 100)");

	dog_pointer->tailwag = 345;
	// 이제 345
	lua.script("assert(dog.tailwag == 345)");

	std::cout << std::endl;

	return 0;
}
```

---

## C++ classes put into Lua (Lua에 넣은 C++ 클래스)

[이 섹션](https://sol2.readthedocs.io/en/latest/tutorial/cxx-in-lua.html)을 참조하세요. 또한 [기본 예제](https://github.com/ThePhD/sol2/blob/develop/examples/source/usertype.cpp), [특수 함수 예제](https://github.com/ThePhD/sol2/blob/develop/examples/source/usertype_special_functions.cpp) 및 [초기화자 예제](https://github.com/ThePhD/sol2/blob/develop/examples/source/usertype_initializers.cpp)를 확인하세요! C++에서 클래스 사용을 보여주는 예제가 훨씬 더 많이 있으므로 필요에 따라 간단하거나 복잡할 수 있으므로 모두 신중하게 살펴보세요.

---

## namespacing (네임스페이싱)

열거형이나 usertype을 등록하기 전에 테이블을 만들고 원하는 네임스페이스 이름을 지정하여 네임스페이싱을 에뮬레이트할 수 있습니다:

```cpp
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

#include <iostream>
#include <assert.hpp>

int main() {
	std::cout << "=== namespacing ===" << std::endl;

	struct my_class {
		int b = 24;

		int f() const {
			return 24;
		}

		void g() {
			++b;
		}
	};

	sol::state lua;
	lua.open_libraries();

	// Lua에서 "bark" 네임스페이싱
	// 네임스페이싱은 테이블에 것을 넣는 것입니다
	// 존재하지 않으면 강제 생성
	auto bark = lua["bark"].get_or_create<sol::table>();
	// 동등함:
	//sol::table bark = lua["bark"].force(); // 테이블 생성 강제
	// 동등하고 더 유연함:
	//sol::table bark = lua["bark"].get_or_create<sol::table>(sol::new_table());
	// 동등하지만 덜 효율적/추함:
	//sol::table bark = lua["bark"] = lua.get_or("bark", lua.create_table());
	bark.new_usertype<my_class>("my_class",
		"f", &my_class::f,
		"g", &my_class::g); // 일반적인 방식

	// 함수도 추가할 수 있습니다 (전역 테이블처럼)
	bark.set_function("print_my_class", [](my_class& self) { std::cout << "my_class { b: " << self.b << " }" << std::endl; });

	// 작동합니다
	lua.script("obj = bark.my_class.new()");
	lua.script("obj:g()");

	// 이 함수 호출도 작동합니다
	lua.script("bark.print_my_class(obj)");
	my_class& obj = lua["obj"];
	c_assert(obj.b == 25);

	std::cout << std::endl;

	return 0;
}
```

이 기법은 네임스페이스와 같은 함수와 클래스를 등록하는 데 사용할 수 있습니다. 원하는 만큼 깊게 만들 수 있습니다. 테이블을 만들고 Lua 스크립트나 동등한 sol 코드를 사용하여 적절하게 이름을 지정하기만 하면 됩니다. 테이블이 먼저 존재하기만 하면(예: 스크립트를 사용하거나 sol의 메서드 중 하나 또는 원하는 것을 사용하여 만들기) sol::table의 추상화를 사용하여 해당 테이블에 원하는 것을 특별히 넣을 수 있습니다.

---

## there is a lot more (더 많은 것이 있습니다)

- [usertypes 페이지](https://sol2.readthedocs.io/en/latest/api/usertype.html)는 함수에 대한 엄청난 양의 기능을 나열합니다
- [unique usertype traits](https://sol2.readthedocs.io/en/latest/api/unique_usertype_traits.html)는 boost와 Unreal과 같은 다른 라이브러리 프레임워크의 handle/RAII 타입을 특수화하여 sol과 함께 작동하도록 할 수 있습니다. 사용자 정의 스마트 포인터, 사용자 정의 핸들 등을 허용합니다
- [containers 페이지](https://sol2.readthedocs.io/en/latest/containers.html)는 컨테이너와 같은 usertype에 대한 모든 것을 처리하는 방법에 대한 전체 정보를 제공합니다
- [functions 페이지](https://sol2.readthedocs.io/en/latest/api/function.html)는 함수에 대한 수많은 기능을 나열합니다
- sol::variadic_args로 함수의 가변 인수
- 여러 다른 타입의 인수를 반환하기 위한 variadic_results도 함께 제공
- 다른 투명한 인수 타입과 함께 현재 lua_State*를 얻기 위한 this_state
- [metatable 조작](https://sol2.readthedocs.io/en/latest/api/metatable.html)은 사용자가 단일 타입에서 인덱싱, 함수 호출 및 기타 작업이 작동하는 방식을 변경할 수 있도록 합니다
- [소유권 의미론](https://sol2.readthedocs.io/en/latest/api/usertype.html#usertype-memory)은 Lua가 자체 내부 참조 및 (원시) 포인터를 처리하는 방법을 설명합니다
- [stack 조작](https://sol2.readthedocs.io/en/latest/api/stack.html)으로 스택을 안전하게 다룹니다. 타입에 대해 stack::get/stack::check/stack::push의 사용자 정의 포인트를 정의할 수도 있습니다
- 저수준 스택 API와 동일한 이점과 편의성을 얻지만 지정할 수 있는 객체에 넣기 위한 [make_reference/make_object](https://sol2.readthedocs.io/en/latest/api/make_reference.html) 편의 함수
- Lua 레지스트리에 복사하지 않고 제로 오버헤드 sol 추상화를 갖기 위한 [stack references](https://sol2.readthedocs.io/en/latest/api/stack_reference.html)
- 오버로드된 함수가 있는 경우 [오버로드 해결](https://sol2.readthedocs.io/en/latest/api/resolve.html); 더 깨끗한 캐스팅 유틸리티. 기본 매개변수를 에뮬레이트하려면 이것을 사용해야 합니다
