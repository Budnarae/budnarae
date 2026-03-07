
---

#language/cpp 

*mutable*

---

**mutable**은 다음의 의미를 가진 키워드이다.

*const 함수 내에서의 값의 변경을 예외적으로 허용한다.*

아래의 예제와 같이 사용할 수 있다.

```cpp

#include <iostream>
using namespace std;

class SoSimple
{
	private:
		int num1;
		mutable int num2;
	public :
		void CopyToNum2() const
		{
			num2 = num1;
		}
};

int main(void)
{
	SoSimple sm(1, 2);
	sm.CopyToNum2(); // const 함수에서 mutable 멤버변수를 변경하고 있다.

	return 0;
}

```

과도한 mutable 사용은 함수의 const 선언을 의미없게 하므로 지양하여야 한다.

---

참고자료

#참고도서/윤성우의_열혈_cpp_프로그래밍

---
