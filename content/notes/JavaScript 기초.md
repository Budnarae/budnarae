---
title: '*사탄 들린 언어*'
tags:
  - 'language/JavaScript'
  - 'web'
---

# 자바스크립트란?

**자바스크립트 JavaScript**는 웹 브라우저에서 사용하는 프로그래밍 언어이다.

# 자바스크립트의 기본 용어

**표현식 expression** : 자바스크립트에서 값을 만들어내는 간단한 코드

**문장 statement** : 하나 이상의 표현식의 모음. 문장 끝에는 세미콜론 또는 줄바꿈을 입력한다 (둘 다 입력할 수도 있다.)

**키워드 keyword** : 자바스크립트가 처음 만들어질 때 정해놓은 특별한 의미가 있는 단어

**식별자 identifier** : 프로그래밍 언어에서 이름을 붙일 때 사용하는 단어. 주로 변수명이나 함수명으로 사용한다. 자바스크립트 식별자를 만들 때는 다음의 규칙을 준수해야 한다.

- 키워드를 사용하지 말아야 한다.
- 숫자로 시작하지 말아야 한다.
- 특수 문자는 \_와 $만 허용한다.
- 공백 문자를 포함할 수 없다.

그리고 식별자의 선언에 있어 다음과 같은 관례들이 존재한다.

- **클래스**의 이름은 항상 대문자로 시작한다.
- **변수**와 **인스턴스**, **함수**, **메소드**의 이름은 항상 소문자로 시작한다.
- 여러 단어로 이루어진 **식별자**는 각 단어의 첫 글자를 대문자로 한다(Camel 케이스).

그리고 자바스크립트에서는 아래와 같이 식별자를 분류할 수 있다.

| 구분                  | 단독으로 사용 | 다른 식별자와 사용 |
| --------------------- | ------------- | ------------------ |
| 식별자 뒤에 괄호 없음 | 변수          | 속성               |
| 식별자 뒤에 괄호 있음 | 함수          | 메소드             |

위 표에서 속성과 메소드는 보통 객체나 클래스의 하위 단위로 존재하는 식별자를 의미한다.

# 주석

주석은 아래와 같이 사용한다.

```javascript

// 한 줄만 주석 처리

/*
	여
	러
	줄
	주
	석
	처
	리
*/

```

# 출력

## 개발자 콘솔 사용하기

맥 기준으로, 크롬에서 **option + cmd + I**를 사용하면 개발자 콘솔을 열 수 있다.
간단한 표현식의 결과를 확인하기 좋다.

## alert

alert() 함수를 사용하면 웹 브라우저에 경고창을 띄울 수 있다. alert() 함수는 다음과 같이 사용한다.

```javascript

alert('Hello JavaScript...!');

```

## console.log

console.log() 함수를 사용하면 개발자 콘솔을 통해 매개변수로 전달한 값을 출력할 수 있다.

```javascript

console.log('Hello JavaScript...!')

```

# 기본 자료형

## 문자열 자료형

문자들의 집합을 **문자열 string**이라고 한다. 자바스크립트에서는 문자가 하나 이상이면 **문자열 자료형**이라고 한다.

자바스크립트에서는 큰따옴표 또는 작은따옴표를 사용하여 문자열을 만들 수  있다.

```javascript

'안녕하세요.';

"안녕하세요.";

```

문자열 안에 따옴표를 사용해야 한다면 따옴표 2개를 모두 사용한다.

```javascript

// 큰 따옴표를 쓰고 싶으면 작은 따옴표 안에 넣는다

'큰 따옴표 " 입니다';

// 작은 따옴표를 쓰고 싶으면 큰 따옴표 안에 넣는다

'작은 따옴표 " 입니다';

```

또는 **이스케이프 문자(\)**를 사용하여 따옴표를 문자 그대로 사용할 수 있다.

```javascript

"작은 따욤표 \'과 큰따옴표 \"입니다."

```

이스케이프 문자는 다음과 같이 사용되기도 한다.

\n : 줄바꿈을 의미한다
\t : 탭을 의미한다
\\ : 역슬래시(\) 그 자체를 의미한다.

### 문자열 연산자

문자열 사이에 덧셈 기호(+)를 사용하면 문자열을 연결할 수 있다. 이때 덧셈 기호를 **문자열 연결 연산자**라고 한다.

```javascript

// "AB"를 결과로 내놓음
"A" + "B";

```

문자열 내부의 문자 하나를 선택할 때는 문자 선택 연산자를 사용한다.

```javascript

// '안'이 출력됨.
"안녕하세요"[0];

```

문자열의 길이를 구할 때는 length 속성을 사용한다.

```javascript

// 5가 반환됨

"안녕하세요".length;

```

### 템플릿 문자열

문자열에 표현식을 적용시키고 싶으면 **템플릿 문자열**을 사용한다. 템블릿 문자열은 백틱(\`) 기호로 감싸 만든다. 문자열 내부에 ${표현식} 과 같이 사용하면 표현식이 문자열 안에서 계산된다.

```javascript

// 출력값: 표현식 273 + 52의 값은 325입니다.
console.log(`표현식 273 + 52의 값은 ${273 + 52}입니다.`);

```

## 숫자 자료형

자바스크립트는 정수와 실수를 모두 **숫자 자료형**이라는 단일 카테고리로 취급하여 처리한다.
그 외의 숫자 자료형의 특성은 c 언어와 동일하므로 생략한다(사칙연산을 적용할 수 있고 나머지 연산자가 있고 등등).

## 불 자료형

**불 자료형**은 true, false 2를 다루는 자료형이다.

불 자료형은 비교 연산자를 사용해서 만들 수 있다. 자바스크립트의 비교 연산자는 아래와 같다.

| 연산자 | 설명          |
| ------ | ------------- |
| ===    | 양쪽이 같다   |
| !==    | 양쪽이 다르다 |
| >      |               |
| <      |               |
| >=     |               |
| <=     |               |
| !      |               |
| &&     |               |
| \|\|   |               |

> \|\| 연산자의 경우, 좌변의 표현식이 참이면 우변의 식은 실행시키지 않는다. && 연산자의 경우, 좌변의 표현식이 거짓이면 우변의 식은 실행시키지 않는다. 이러한 문법적 요소를 이용할 수 있다.

문자열 자료형은 **ascii 순으로 대소 비교를 적용**한다.

```javascript

// false를 반환함
"가방" > "하마"

```

### \=\=, !\=\= 연산자와 \=\=\=, !\=\=\= 연산자의 차이

=== 연산자와 !== 연산자는 **값과 자료형이 같은지 비교한다**. 

하지만 \== 연산자와 != 연산자는 **자료형에 관계 없이 값이 같은지만 비교한다**.
자료형 변환 등을 적용한 결과가 같으면 같은 값이라고 취급한다는 뜻이다.

```javascript

// 자료형이 달라도 어떻게든 변환을 하고 나면 값이 같아지므로 true이다.
1 == "1";

// false가 0으로, "0"이 0으로 변환된 뒤에 비교하므로 true이다.
false == "0";

// 빈 문자열은 false, 비어있는 배열 []은 false로 변환된 뒤에 비교한다.
"" == [];

// 0은 false, 비어있는 배열 []은 false로 변환된 뒤에 비교한다
0 == [];

```

## typeof

자료형의 타입을 확인할 때는 typeof 연산자를 사용한다.

```javascript

// "string"을 반환
typeof('문자열');

// "number"를 반환
typeof(273);

// "boolean"을 반환
typeof(true);

// 다음과 같이 사용할 수 있다.
if (typeof(273) === "number")
	console.log("숫자 자료형입니다.");

```

# 상수와 변수

## 상수

상수는 키워드 **const**를 사용하여 만든다

```javascript

const name = value;

```

### Identifier has already declared

같은 이름으로 상수를 한 번 더 선언하면 발생하는 오류

### Missing initializer in const declaration

상수는 한 번만 선언할 수 있으므로 선언할 때 반드시 값을 함께 지정해줘야 한다. 그렇지 않으면 이 오류가 발생한다.

### Assignment to constant variable

상수의 값을 변경하려 할 때 발생한다.

## 변수

**let** 키워드를 사용하여 변수를 만든다.

```javascript

let name = value;

```

### Identifier has already declared

같은 이름으로 변수를 한 번 더 선언하면 발생하는 오류

### 변수에 적용할 수 있는 연산자

#### 복합 대입 연산자
#### 증감 연산자

c언어와 유사하므로 생략

## undefined 자료형

자바스크립트에서 data가 **undefined**로 취급되는 경우는 아래와 같다.

1. 식별자를 선언하지 않고 사용할때

```javascript

// "undefined"를 반환함
typeof(abc);

```

2. 변수를  선언하면서 값을 지정하지 않은 경우에

```javascript

let a;

typeof(a);

```

# 입력

## 문자열 입력

문자열 자료형을 입력받을 때 사용하는 함수는 prompt()이다. 다음과 같은 형태로 사용한다.

```javascript

const input = prompt(메시지 문자열, 기본 입력 문자열);

```

## 불 입력

문자열 외에 불 자료형도 값으로 입력받을 수 있다. 이때 confirm() 함수를 사용한다.

```javascript

const input = confirm(메시지 문자열);

```

# 자료형 변환

## 숫자 자료형으로 변환

다른 자료형을 숫자 자료형으로 변환할 때는 Number() 함수를 사용한다.

```javascript

Number("209348028");

```

다른 문자가 들어있어서 숫자로 변환할 수 없는 문자열의 경우 **NaN (Not a Number)**라는 값을 출력한다.
NaN은 자바스크립트에서 숫자이지만, 숫자로 나타낼 수 없는 숫자를 뜻한다.

## 문자열 자료형으로 변환

String() 함수를 사용한다.

```javascript

// "289"를 반환
String(289);

```

## 불 자료형으로 변환

Boolean 함수를 사용한다.

```javascript

/* false case */
Boolean(0);
Boolean(NaN);
Boolean("");
Boolean(null);

// undefined variable ==> false
let variable;
Boolean(variable);

```

# 조건문 (if else, switch)
# 삼항연산자

c언어와 동일하므로 생략

# 짧은 조건문

다음의 조건문은 아래와 같이 짧은 조건문으로 변환할 수 있다.

```javascript

let key = 4;

if (key == 4)
	console.log("key is 4");

// 좌변이 거짓이어야만 우변이 실행됨
key != 4 || console.log("key is not 4");

// 좌변이 참이어야만 우변이 실행됨
key == 4 && console.log("key is 4");

```

# 배열

## length

배열 내부에 들어 있는 요소의 개수를 확인할 때는 배열의 length 속성을 사용한다.

```javascript

arr.length;

```

## push()

배열 뒷부분에 요소를 추가할 때는 **push()** 메소드를 사용한다.

```javascript

arr.push(요소);

```

## 인덱스를 사용해 배열 뒷부분에 요소 추가하기

자바스크립트에서 배열의 길이는 고정이 아니다. 다음과 같이 3개의 요소를 가진 배열을 만든 뒤, 10번째 인덱스에 요소를 삽입하면 사이에 남는 공간은 비어있는 것으로 취급된다.

```javascript

const fruitA = ['사과', '배', '바나나'];
fruitA[10] = '귤'

// 출력값: ['사과', '배', '바나나', empty x 7, "귤"]
fruitA;

```

다음과 같이 length 속성을 사용하여 배열의 마지막 위치에 요소를 추가할 수 있다.

```javascript

arr[arr.length] = "new value";

```

## 배열 요소 제거하기

### 인덱스 기반 제거

배열의 특정 인덱스에 있는 요소를 제거할 때는 **splice()** 메소드를 사용한다.

```javascript

array.splice(인덱스, 제거할 요소의 개수);

```

### 값 기반 제거

값을 기반으로 요소를 제거할 때는 배열 내부에서 특정 값의 위치를 찾는 **indefOf()** 메소드를 사용해서 값의 위치를 추출한 뒤 **splice()** 메소드를 사용해 제거한다.

```javascript

array.splice(array.indexOf(target), 1);

```

참고로 indexOf() 메소드는 배열 내부에 요소가 있을 경우 인덱스를 리턴한다. 하지만 배열 내부에 요소가 없을 때는 -1을 리턴한다.

> 문자열에도 indexOf() 메소드가 있다. 이를 이용하면 문자열 내부에서 특정 문자열의 위치를 찾을 수 있다.

### 특정 값을 가진 요소 전부 제거

indexOf() 메소드와 splice() 메소드는 배열 내부 요소를 하나만 제거할 수 있다. 배열 내부에서 특정 값을 가진 요소를 모두 제거하고 싶을 때는 filter() 메소드를 사용해야 하면 사용방법은 아래와 같다.

```javascript

const array = ['사과', '배', '바나나', '귤', '귤']

// 귤이 아닌 요소만 필터링을 통해 남긴다.
array.filter((item) => item !== '귤');

```

### 배열의 특정 위치에 요소 추가하기

배열의 특정 위치에 요소를 추가할 때 또한 splice() 메소드를 사용한다. splice() 메소드의 2번째 매개변수에 0을 입력하면 splice() 메소드는 아무 것도 제거하지 않으며, 3번째 매개변수에 추가하고 싶은 요소를 입력한다.

다음과 같이 사용한다.

```javascript

array.splice(index, 0, value);

```

# 반복문

## for in 반복문

for in 반복문은 배열 요소를 하나하나 꺼내서 특정 문장을 실행할 때 사용한다.

```javascript

const todos = ['우유 구매', '업무 메일 확인하기', '필라테스 수업'];

for (const i in todos)
{
	console.log(`${i}번째 할 일: ${todos[i]}`);
}

/*
	실행 결과
	0번째 할 일: 우유 구매
	1번째 할 일: 업무 메일 확인하기
	...
*/

```

for 반복문의 **반복 변수**(위 코드에서 i)에는 요소의 인덱스들이 들어온다. 이를 활용해서 배열 요소에 접근할 수 있다.

for in 반복문은 불안정한 요소가 조금 있으므로, 후술할 다른 반복문을 사용하는 편이 낫다.

## for of 반복문

for of 반복문은 반복 변수에 요소의 값이 들어간다.

```javascript

const todos = ['우유 구매', '업무 메일 확인하기', '필라테스 수업'];
for (const todo of todos)
{
	console.log(`오늘의 할 일: ${todo}`);
}

```

## for 반복문

for 반복문은 특정 횟수만큼 반복하고 싶을 때 사용하는 범용적인 반복문이다.

```javascript

for (let i = 0; i < 반복 횟수; i++)
{
	문장;
}

```

## while 반복문
## break 키워드
## continue 키워드
## 중첩 반복문

c 언어와 동일하므로 생략

# 함수

자바스크립트의 함수는 다른 언어의 함수와 동일하게 **매개변수**를 **함수 몸체**에서 처리한 후 **리턴**한다. 함수의 자료형은 **function**이다.

## 익명 함수

이름이 붙어 있지 않은 함수를 익명 함수 anonymous function이라고 표현한다.
익명 함수의 기본 형태는 아래와 같다.

```javascript

function () { ... }

```

```javascript

const func = function() {
	console.log("자바스크립트로 만든 첫번째 익명 함수.");
}

func();

```

익명 함수는 이름이 부여되어 있지 않으므로 일반적으로 변수에 붙여서 사용한다.

## 선언적 함수

일반적으로는 이름이 있는 함수를 많이 사용한다.
이름을 부여하여 생성한 함수를 선언적 함수라고 한다.

```javascript

function functionName() { ... }

```

```javascript

function func() {
	console.log("자바스크립트로 만든 첫번째 선언적 함수.");
}

func();

```

## 선언적 함수와 익명 함수의 차이

**선언적 함수**는 순차적인 코드의 실행이 일어나기 전에 생성된다. 따라서 선언적 함수는 같은 블록이라면 어디에서 함수를 호출해도 상관없다.

아래와 같이 함수 선언 이전에 함수를 호출해도 문제없이 호출된다.

```javascript

// 선언적 함수를 호출한다.
선언적함수();

// 같은 이름의 함수가 있으면 나중에 생성된 함수가 먼저번 함수를 뒤집어쓴다.
function 선언적함수()
{
	console.log('1번째 선언적 함수입니다.');
}
function 선언적함수()
{
	console.log('2번째 선언적 함수입니다.');
}

```

반면에 익명함수는 순차적인 코드 실행에서 코드가 해당 줄을 읽을 때 생성된다. 따라서 익명 함수로 위와 같은 예제를 실행 시키면 에러가 발생하게 된다.

그러면 아래의 코드를 보자

```javascript

// 익명 함수 생성
func = function () {
	console.log('익명 함수입니다.');
}

// 선언적 함수를 생성하고 할당
function func () {
	console.log('선언적 함수입니다.');
}

// 함수를 호출한다.
func();

```

익명 함수는 우리가 코드를 읽을 때와 같은 순서로 함수가 선언되지만, 선언적 함수는 우리가 코드를 읽는 순서와 다르게 함수가 선언된다. 이러한 특성 때문에 예측하기 쉬운 익명 함수가 더 선호된다.

### let 키워드를 사용한 중복 방지

let 키워드에는 동일한 식별자의 선언을 방지하는 기능이 있다.

```javascript

let a = 10;

// error
let a;

```

따라서 let 키워드를 통해 선언한 변수에 익명 함수를 붙이면 함수의 중복 선언을 방지할 수 있다.

```javascript

// 익명 함수를 생성한다
let func = function() {
	console.log('익명 함수입니다.');
}

// 선언적 함수를 생성하고 할당한다. 위의 let 키워드 때문에 에러가 발생한다.
function func () {
	console.log('선언적 함수입니다.');
}

// 함수를 호출합니다.
func()

```

따라서 한 가지로 통일해서 사용하는 것이 오류의 위험을 더 줄일 수 있고, 통일한다면 익명 함수로 통일해서 사용하는 것이 안전을 위해서 더 편한 선택이다.

## 나머지 매개변수

호출할 때 매개변수의 개수가 고정적이지 않은 함수를 **가변 매개변수 함수**라고 부른다. 자바스크립트에서 이러한 함수를 구현할 때는 **나머지 매개변수 rest parameter**라는 특이한 형태의 문법을 사용한다. 나머지 매개변수의 기본적인 사용 방법은 다음과 같다.

```javascript

function functionName(...나머지 매개변수) { ... }

```

함수의 매개변수 앞에 마침표 3개(...)를 입력하면 매개변수들이 **배열**로 들어온다. 나머지 매개변수의 작동을 확인할 수 있는 간단한 예제를 보도록 하자.

```javascript

function sample(...items)
{
	console.log(items);
}

sample(1, 2);
sample(1, 2, 3);
sample(1, 2, 3, 4);

/*
실행 결과
[1, 2]
[1, 2, 3]
[1, 2, 3, 4]
*/

```

```javascript


	// 매개변수 items는 배열처럼 사용한다.
	function min(...items)
	{
		let output = items[0];
		for (const item of items)
		{
			if (output > item)
			{
				output = item;
			}
			return output;
		}
	}

	// 함수 호출하기
	console.log('min(52, 273, 24)');
	console.log(`${min(52, 273, 24)}`);

/*
실행 결과
min(52, 273, 24)
= 24
*/

```

### 나머지 매개변수와 일반 매개변수 조합하기

나머지 매개변수는 다음 패턴과 같이 일반적인 매개변수와 조합해서 사용할 수 있다.

```javascript

function functionName(매개변수, 매개변수, ...나머지_매개변수) {}

```

## 전개 연산자

다음과 같이 매개변수로 배열을 입력할 수 없고 숫자를 입력해야 하는 함수가 있다고 가정하자.

```javascript

min(52, 273, 24);

```

이때 다음과 같이 배열을 사용해 min 함수를 사용하려면 기본적으로 배열 요소를 하나하나 전개해서 입력하는 방법밖에 생각할 수 없다.

```javascript

min(array[0], array[1], array[2], array[3]);

```

이런 상황에 대비하고자 자바스크립트는 배열을 전개해서 함수의 매개변수로 전달해주는 **전개 연산자 spread operator**를 제공한다. 전개 연산자는 다음과 같이 배열 앞에 마침표 3개(...)를 붙이는 형태로 사용한다.

```javascript

functionName(...array);

```

## 기본 매개변수

c 언어와 동일하므로 생략

# 함수 고급

다른 프로그래밍 언어는 함수를 지정된 위치에서 만들어야 하지만, 자바스크립트는 '함수도 하나의 자료'라는 개념을 가지고 있어서 중간에 만들 수 있다. 이는 2010년 전후에 등장한 **비동기 프로그래밍**을 이끌었다. 자바스크립트의 익명 함수는 문법적 가치를 크게 인정받아 다른 프로그래밍 언어로 전파되었다. 자바스크립트의 익명 함수는 문법적 가치를 크게 인정받아 다른 프로그래밍 언어로 전파되어 **람다** 또는 **익명 함수**라는 이름으로 기본 문법에 포함되었다.

## 콜백 함수

자바스크립트는 함수도 하나의 자료형이므로 매개변수로 전달할 수 있다(c 언어에서 함수 포인터를 전달하는 것과 유사하다). 이렇게 매개변수로 전달하는 함수를 **콜백 callback 함수**라고 한다.

```javascript

// 함수를 선언한다.
function callThreeTimes (callback)
{
	for (let i = 0; i < 3; i++)
	{
		// callback이라는 매개변수는 함수이므로 호출할 수 있다.
		callback(i);
	}
}

function print (i)
{
	console.log(`${i}번째 함수 호출`);
}

// 함수를 호출한다.
callThreeTimes(print);

```

이전 예제의 선언적 함수를 익명 함수로 변경한다면 다음과 같이 코드를 구성할 수 있다.

```javascript

// 함수를 선언한다.
function callThreeTimes (callback)
{
	for (let i = 0; i < 3; i++)
	{
		// callback이라는 매개변수는 함수이므로 호출할 수 있다.
		callback(i);
	}
}

// 함수를 호출한다.
callThreeTimes(function (i) {
	console.log(`${i}번째 함수 호출`);
});

```

## forEach()

콜백 함수를 활용하는 가장 기본적인 함수는 **forEach()** 메소드이다. forEach() 메소드는 배열이 갖고 있는 함수(메소드)로써 단순하게 배열 내부의 요소를 사용해서 콜백 함수를 호출해준다.

배열이 갖고 있는 메소드 중에서 콜백 함수를 활용하는 메소드는 다음과 같은 형태의 콜백 함수를 사용한다.

```javascript

function (value, index, array) {}

```

```javascript

const numbers = [273, 52, 103, 32, 57];

numbers.forEach(function (value, index, array) {
	console.log(`${index}번째 요소 : ${value}`);
})

```

## map()

map() 메소드도 배열이 갖고 있는 함수 중 하나로, map() 메소드는 콜백 함수에서 리턴한 값들을 기반으로 새로운 배열을 만든다.

```javascript

// 배열을 선언한다
let numbers = [273, 52, 103, 32, 57];

// 배열의 모든 값을 제곱한다
numbers = numbers.map(function (value, index, array) {
	return value * value;
})

// 출력한다
numbers.forEach(console.log);

```

### 원하는 매개변수만 받기

배열의 메소드의 매개변수에 전달하는 콜백 함수의 완전한 형식은 `function (value, index, array) {}`가 맞지만, 일반적으로 value 또는  value와 index만 사용하는 경우가 많다.

콜백 함수의 매개변수는 모두 입력할 필요 없고, 사용하고자 하는 위치의 것만 순서에 맞춰 입력하면 된다.

```javascript

// 배열을 선언한다
let numbers = [273, 52, 103, 32, 57];

// 배열의 모든 값을 제곱한다
numbers = numbers.map(function (value) {
	return value * value;
})

// 출력한다
numbers.forEach(console.log);

```

## filter()

**filter()** 메소드도 배열이 갖고 있는 함수이다. filter() 메소드는 콜백 함수에서 리턴하는 값이 true인 것들만 모아서 새로운 배열을 만드는 함수이다.

```javascript

const numbers = [0, 1, 2, 3, 4, 5];
const evenNumbers = numbers.filter(function (value) {
	return (value % 2 === 0)
})

console.log(`원래 배열: ${numbers}`);
console.log(`짝수만 추출: ${evenNumbers}`);

```

## 화살표 함수

**화살표 arrow 함수**는 단순한 형태의 콜백 함수를 쉽게 입력하고자 하는 문법적 요소이다. 화살표 함수는 function 키워드 대신 화살표(=>)를 사용하며, 다음과 같은 형태로 생성하는 간단한 함수이다.

```javascript

(매개변수) => {
	...
}

```

다음과 같이 더 간편한 형태로 사용할 수도 있다.

```javascript

(매개변수) => 리턴값

```

map()과 사용하는 예.

```javascript

array.map((value) => value * value);

```

> 익명함수와 화살표 함수는 내부에서 this 키워드가 지칭하는 대상이 다르다는 등의 미세한 차이가 있다.

## 메소드 체이닝

어떤 메소드가 리턴하는 값을 기반으로 해서 함수를 줄줄이 사용하는 것을 **메소드 체이닝 method chaining**이라고 부른다.

```javascript

// 배열을 선언한다
let numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

// 배열의 메소드를 연속적으로 사용한다
numbers
	.filter((value) => value % 2 === 0)
	.map((value) => value * value)
	.forEach((value) => {
		console.log(value);
	})

```

## 타이머 함수

자바스크립트에는 다음과 같이 특정 시간마다 또는 특정 시간 이후에 콜백 함수를 호출할 수 있는 **타이머 timer 함수**들이 있다. 이 함수를 사용하면 시간과 관련한 처리를 할 수 있다.

| 함수 이름              | 설명                                    |
| ---------------------- | --------------------------------------- |
| setTimeout(함수, 시간) | 특정 시간 후에 함수를 한 번 더 호출한다 |
| setInterval(함수, 시간)                       |  특정 시간마다 함수를 호출한다                                       |

```javascript

// 타이머 걸기

setTimeout(() => {
	console.log('1초 후에 실행')
}, 1 * 1000)

let count = 0;
setInterval(() => {
	console.log(`1초마다 실행됩니다(${count}번째)`);
	count++;
}, 1 * 1000)

```

**setTimeout() 함수와 setInterval() 함수**를 사용해서 특정 시간 후에 코드를 호출한다. 코드를 실행하면 1초 후에 setTimeout() 함수의 콜백 함수가 실행되고, 1초마다 setInterval() 함수의 콜백 함수가 실행되는 것을 볼 수 있다.

특이사항으로, 2번째 매개변수에 시간을 입력할 때 밀리초로 입력하여야 한다.

타이머를 종료하고 싶을 때는 **clearTimeout() 함수와 clearInterval() 함수**를 사용한다.

| 함수 이름               | 설명                                          |
| ----------------------- | --------------------------------------------- |
| clearTimeout(timer_id)  | setTimeout() 함수로 설정한 타이머를 제거한다  |
| clearInterval(timer_id) | setInterval() 함수로 설정한 타이머를 제거한다 |

이 함수들의 매개변수에는 타이머 ID라는 것을 넣는데, 타이머 ID는 setTimeout() 함수와 setInterval() 함수의 리턴값이다.

```javascript

// 타이머 취소하기
let id;
let count = 0;
id = setInterval(() => {
	console.log(`1초마다 실행됩니다(${count}번째)`);
	count++;
}, 1 * 1000);

setTimeout(() => {
	console.log('타이머 종료.');
	clearInterval(id);
}, 5 * 1000);

```

# 스코프

변수가 유효한 범위를 **스코프 scope**라고 부르는데, 이 스코프는 같은 단계에 있을 경우 무조건 충돌이 일어난다.
자바스크립트에서 이러한 스코프 단계를 변경하는 방법은

1. 중괄호를 사용해서 블록을 만들거나
2. 함수를 생성해서 블록을 만드는 방법이다

## 섀도잉

```javascript

let pi = 3.14;
console.log(`파이 값은 ${pi}입니다.`);

// 블록을 사용한 스코프 생성
{
	let pi = 3.141592;
	console.log(`파이 값은 ${pi}입니다.`);
}
console.log(`파이 값은 ${pi}입니다.`);

// 함수 블록을 사용한 스코프 생성
function sample() {
	let pi = 3.141592;
	console.log(`파이 값은 ${pi}입니다.`);
}
sample();
console.log(`파이 값은 ${pi}입니다.`);

```

위와 같이 블록 내부에서 외부의 변수와 같은 이름으로 변수를 선언하면 변수가 외부 변수와 충돌하지 않고 외부 변수를 가린다. 내부 블록에서는 내부 블록에서 선언한 변수만 볼 수 있다. 이렇게 블록이 다른 경우 내부 변수가 외부 변수를 가리는 현상을 조금 어려운 표현으로 **섀도잉 shadowing**이라고 부른다.

# 엄격 모드

여러 자바스크립트 코드를 보면 블록의 가장 위쪽에 'use strict'라는 문자열이 등장하는 것을 볼 수 있다. 이를 **엄격 모드 strict mode**라고 부르는 기능으로 자바스크립트는 이러한 문자열을 읽어들인 순간부터 코드를 엄격하게 검사한다.

자세한 것은 [모질라 엄격 모드 문서](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Strict_mode)를 참고.

# 객체

자바스크립트에서 여러 자료를 다룰 때는 **객체 Object**를 사용한다. 객체에 typeof 연산자를 적용해보면 **"object"**라는 문자열이 출력된다.

자바스크립트에서는 앞서 다뤘던 배열도 객체로 취급한다. length 등의 속성과 filter() 등의 메소드를 사용할 수 있었던 것도 배열이 객체로 취급되기 때문이다.

객체는 중괄호( {...} )로 생성하며, 다음과 같은 형태의 자료를 쉼표(,)로 연결해서 입력한다.

`키: 값`

아래는 객체를 선언하는 구체적인 예시이다.

```javascript

const product = {
	제품명: '7D 건조 망고',
	유형: '당절임',
	성분: '망고, 설탕, 메타중아황산나트륨, 치자황색소',
	원산지: '필리핀'
}

```

다음과 같이 객체 뒤에 대괄호를 사용하고 키를 입력하면 객체의 요소에 접근할 수 있다.

```javascript

product['제품명'];
product['유형'];
product['성분'];
product['원산지'];

```

객체는 대괄호 대신에 다른 언어와 유사하게 온점을 사용하여 요소에 접근할 수도 있다.

```javascript

product.제품명;
product.유형;
product.성분;
product.원산지;

```

단, 아래와 같이 식별자로 사용할 수 없는 문자열을 키로 사용했을 때는 무조건 대괄호를 사용해야 한다.

```javascript

// 식별자로 사용할 수 없는 단어를 키로 사용할 때는 문자열을 사용한다.
const object = {
	"with space" : 273,
	"with )%($#*(*@))" : 52
}

// 객체의 요소에 접근한다.
// 식별자로 사용할 수 없는 키에 접근할 때는 대괄호를 사용한다.
object["with space"];
object["with )%($#*(*@))"];

```

## 메소드

객체의 속성 중 함수 자료형인 속성을 특별히 **메소드 method**라고 부른다. 

메소드 내에서 자기 자신이 가진 속성을 출력하고 싶을 때는 자신이 가진 속성임을 분명하게 표시해야 한다. 자기 자신이 가진 속성이라는 것을 표시할 때는 **this 키워드**를 사용한다.

```javascript

// 변수 선언
const pet = {
	name: '구름',
	eat: function (food) {
		alert(this.name + '은/는' + food + '을/를 먹습니다.');
	}
}

// 메소드를 호출한다.
pet.eat('밥');

```

## 동적인 요소 변경

자바스크립트에서는 객체가 선언된 이후에도 동적으로 요소를 추가하거나 제거하는 것이 가능하다.

요소를 추가할 때는 속성을 지정하고 값을 입력하면 된다.
요소를 제거할 때는 `delete 객체.속성`의 형식으로 제거한다.

```javascript

// 객체 선언
const student = {};

// 객체의 속성 추가
student.이름 = '윤인성';
student.취미 = '악기';
student.장래희망 = '생명공학자';

// 출력해보기
console.log(JSON.stringify(student, null, 2));

// 객체의 속성 제거
delete student.장래희망;

// 출력해보기
console.log(JSON.stringify(student, null, 2));

```

## 메소드 간단 선언 구문

최신 버전 자바스크립트에서는 `function () {}` 보다 간단한 형식으로 메소드를 선언할 수 있는 전용 구문이 있다.

아래와 같이 선언한다.

```javascript

// 변수를 선언
const pet = {
	name: '구름',
	eat (food) {
		alert(this.name + '은/는' + food + '을/를 먹습니다.');
	}
}

// 메소드 호출
pet.eat('밥');

```

## 화살표 함수를 사용한 메소드

`function () {}` 형태로 선언하는 **익명 함수**와 `() => {}` 형태로 선언하는 **화살표 함수**는 객체의 메소드로 사용될 때 **this** 키워드를 다루는 형식이 다르다.

```javascript

const test = {
	a: function () {
		console.log(this);
	},
	b: () => {
		console.log(this);
	}
}

// 메소드 호출
test.a();
test.b();

```

화살표 함수 내에서 this 키워드를 사용하면 일반적으로 객체 스스로가 아닌 window 객체가 호출된다. 이러한 불확실성 때문에 객체 내부에서 화살표 함수를 메소드로 사용하지 않는 편이다.

# 기본 자료형과 객체 자료형 심화

자바스크립트의 data는 크게 **기본 자료형 primitives**과 **객체 자료형 object**로 구분할 수 있다.

## 객체 자료형

자바스크립트에서는 객체로 선언한 요소만 객체가 아니라, **함수**와 배열 또한 객체로 취급 받는다.

```javascript

function b () {}

b.sample = 10;

// 10이 반환되어 제대로 요소가 추가되었음을 확인할 수 있다.
// 기본 자료형에서는 이러한 동작이 불가능하다.
b.sample;

```

함수는 **실행 가능한 객체**라는 특이한 data로 typeof 연산자를 사용해서 자료형을 확인하면 'function'을 출력한다. 함수는 객체의 특성을 완벽하게 가지고 있으므로 자바스크립트에서는 함수를 **일급 객체 first-class object 또는 first-class citizen**에 속한다고 표현하기도 한다.

## 기본 자료형을 객체로 선언하기

기본 자료형은 객체가 아니기 때문에 속성이나 메소드를 가질 수 없지만, 자바스크립트는 기본 자료형을 객체로 선언하는 방법을 제공한다.

아래와 같은 방법으로 **숫자 객체, 문자열 객체, 불 객체**를 생성할 수 있다.

```javascript

const numObj = new Number(10);
const strObj = new String('안녕하세요');
const boolObj = new Boolean(true);

```

위와 같이 생성된 객체들은 기본 자료형의 특징을 온전히 가지면서(연산자를 적용할 수 있다거나 등등) 객체로서의 특성도 활용할 수 있다.

## 기본 자료형의 일시적 승급

앞서 문자열 자료형의 length, indexOf() 등을 사용하였는데, 기본 자료형은 속성, 메소드를 보유할 수 없으므로 이는 이상해 보인다. 이러한 방식의 사용이 가능한 것은 **기본 자료형의 일시적 승급**이라는 특성 때문이다.

자바스크립트는 사용의 편리성을 위해서 기본 자료형의 속성과 메소드를 호출할 때(기본 자료형 뒤에 온점을 찍고 무언가 하려고 하면) 일시적으로 기본 자료형을 객체로 승급시킨다.

이러한 승급은 일시적이다. 따라서 문자열 자료형에 동적으로 속성을 추가하는 등의 동작은 불가능하다.

```javascript

const h = '안녕하세요';

// 일시적으로 객체로 승급되어 sample 속성을 추가할 수 있다
h.sample = 10;

// 하지만 어디까지나 일시적인 승급이기 때문에 추가했던 속성은 이미 소멸하며 undefined를 반환한다.
h.sample;

```

### 일시적 승급 시 자주 사용되는 메소드

#### 숫자 자료형의 경우

##### toFixed()

```javascript

const l = 123.456789;

// 소숫점 3번째 자리에서 반올림하여(즉, 2번째 자리까지만 출력한다) 문자열의 형태로 반환한다.
// 출력값 : "123.46"
l.toFixed(2);

```

##### isNaN(), isFinite()

어떤 숫자가 Nan 또는 Infinity 인지 확인하기 위해 사용한다. 불 형식을 반환한다.

```javascript

// isNaN(), isFinite()는 기본자료형을 승급시켜 사용하는 것이 아닌, 자료형 객체의 메소드로서 호출해야 한다.

int n = 9238048;

// false 반환
Number.isFinite(n);
// false 반환
Number.isNaN(n);

```

#### 문자열 자료형의 경우

##### trim()

문자열 앞뒤의 공백, 줄바꿈을 제거한다.

```javascript

const stringA = '  
줄바꿈 공백  ';

// "줄바꿈 공백"을 반환
stringA.trim();

```

##### split()

delimeter를 사용하여 문자열을 잘라 배열을 만들어 반환한다.

```javascript

const str = "1,2,3,4,5";

// ["1", "2", "3", "4", "5"] 반환
str.split(",");

```

## prototype

문자열 자료형이 기본적으로 indexOf() 등의 메소드를 사용할 수 있는 것처럼, 다른 자료형에도 편리한 메소드나 속성을 지정할 수 있다. 예를 들어 숫자 자료형에 제곱 연산을 지원하는 power 메소드를 추가할 수 있으면 편리할 것이다.

이를 **자료형의 prototype 속성에 추가한다**라고 표현한다.

```javascript

/* 속성의 추가 */

// 객체 자료형 이름.prototype.메소드_이름 = function() {}의 형식으로 사용한다.
Number.prototype.example = 10;

const i = 273;

// 10이 반환된다.
i.sample;

```

```javascript

/* 메소드의 추가 */
Number.prototype.power = function (n = 2) {
	return this.valueOf() ** n;
}

// Number 객체의 power() 메소드를 사용한다.
const a = 12;
console.log('a.power():', a.power());
console.log('a.power(3):', a.power(3));
console.log('a.power(4):', a.power(4));

```

코드에서 **this.valueOf()**로 숫자값을 꺼내 사용하였다. 그냥 this ** n을 해도 아무 문제 없이 계산된다.
하지만 객체 내부에서 값을 꺼내 쓰는 것임을 명확하게 하기 위해서 4행처럼 valueOf() 메소드를 사용하는 것이 일반적이다.

# 기본적으로 지원되는 객체들

## JSON 객체

인터넷에서 문자열로 데이터를 주고 받을 때는 CSV, XML, CSON 등의 다양한 자료 표현 방식을 사용할 수 있다. 현재 가장 많이 사용되는 자료 표현 방식은 **JSON 객체**이다.

JSON은 JavaScript Object Notation의 약자로 자바스크립트의 객체처럼 자료를 표현하는 방식이다.

대부분의 프로그래밍 언어는 JSON 형식의 문자열을 읽어들이는 기능이 있다. 그래서 네트워크를 통해서 각각의 프로그래밍 언어로 만든 애플리케이션들이 데이터를 교환할 때 활용한다.

자바스크립트 객체를 JSON 문자열로 변환할 때는 **JSON.stringify() 메소드**를 사용한다.
반대로 JSON 문자열을 자바스크립트 객체로 전개할 때는 **JSON.parse() 메소드**를 사용한다.

## Math 객체

수학과 관련된 기본적인 연산을 할 때 사용한다.

많이 사용되는 Math 객체 속성으로는 pi, e와 같은 수학 상수가 있다.
메소드로는 Math.sin(), Math.cos(), Math.tan()과 같은 삼각함수도 있다.

### Math.random()

랜덤한 숫자를 생성할 때는 Math.random() 메소드를 사용한다. Math.random() 메소드는 0 이상, 1 미만의 랜덤한 실수를 생성한다. 따라서 그 이상의 범위에서 랜덤한 숫자를 구하려면 생성된 난수에 특정한 수를 곱하거나 더하는 등의 처리가 필요하다.

# 외부 script 파일 읽어들이기(HTML과 js 파일 분리)

방법 1. `<script>` 블록의 `src` 속성에 읽어들일 js 파일의 경로를 기재

```html

<!DOCTYPE html>
<html>
	<head>
		<title></title>
		<script src="test.js"></script>
	</head>
	<body>
	</body>
</html>

```

방법 2. `src` 속성에 외부 라이브러리의 링크 기재하기

```html

<!DOCTYPE html>
<html>
	<head>
		<title></title>
		<script src="https://..."></script>
	</head>
	<body>
	</body>
</html>

```

## CDN

**CDN**이란 **콘텐츠 전송 네트워크**라는 의미이다.

일반적으로 어떤 사이트는 어떤 특정한 지역의 서버에 위치한다. 먼 지역의 서버로부터 서비스를 지원받으려면, 속도가 느리거나, 아니면 서비스를 아예 지원받지 못할 수도 있다.

만약 전 세계 여러 지역에 전송할 데이터를 창고처럼 준비해두고 사용자가 데이터를 요청했을 때 가장 가까운 지역에서 데이터를 전송해준다면 훨씬 빠르게 데이터를 전송할 수 있다. 또한 가까운 지역에 문제가 있으면 그 다음으로 가까운 지역에서 데이터를 전송하면 데이터를 받을 수 없는 문제도 해결할 수 있다. 이러한 통신 네트워크를 CDN이라고 부른다.

*참고로 CDN은 Contents Delivery Network의 약자이다.*

## min 버전 코드

**min** 버전의 자바스크립트 파일은 자바스크립트 코드를 **집핑 zipping**한 파일을 의미한다. 집핑이란 주석이나 개행 등의 코드의 실행에 필수적이지 않은 데이터를 최대한 줄이고 코드를 응축하는 과정을 말한다.

# 객체와 배열 고급

## 속성 존재 여부 확인

객체에 없는 속성에 접근을 시도하면 **undefined 자료형**을 반환한다.

## 기본 속성

다음과 같이 객체에 이미 속성이 존재하면 그대로 두고 그렇지 않다면 속성을 추가하는 기법이 존재한다.

```javascript

const obj = {
	a: "a";
};

obj.a = obj.a !== undefined ? obj.a : "a의 기본 값";

```

## 배열 기반의 다중 할당

최신 자바스크립트부터 배열과 비슷한 작성 기법으로 한 번에 여러 개의 변수에 값을 할당하는 다중 할당 기능이 추가되었다.

```javascript

let [a, b] = [1, 2];

// 1, 2를 출력
console.log(a, b);

// 다음과 같이 스왑을 간편하게 구현할 수 있다.
[a, b] = [b, a];

// 2, 1를 출력
console.log(a, b);

```

## 객체 기반의 다중 할당

최신 자바스크립트에서는 객체 내부에 있는 속성을 꺼내서 변수로 할당할 때 다음과 같은 코드를 사용할 수 있다.

```javascript

{ 속성 이름, 속성 이름 } = 객체
{ 식별자=속성 이름, 식별자=속성 이름 } = 객체

```

```javascript

// 객체를 생성
const object = {
	name: '혼자 공부하는 파이썬',
	price: 18000,
	publisher: '한빛미디어'
}

// 객체에서 변수를 추출한다
const { name, price } = object;
console.log('# 속성 이름 그대로 꺼내서 출력하기');
console.log(name, price);
console.log('');

// name 속성을 a라는 이름으로, price 속성을 b라는 이름으로 꺼낸다.
const { a=name, b=price } = object;
console.log('# 다른 이름으로 속성 꺼내서 출력하기');
console.log(a, b);

```

## 얕은 복사와 깊은 복사

자바스크립트에서도 **얕은 복사**라는 개념이 존재한다. 다음과 같은 형식으로 배열을 복사하면 두 식별자는 같은 배열을 가리키게 된다.

```javascript

// 사야 하는 물건 목록
const obj_200301 = ['우유', '식빵'];
const obj_200302 = obj_200301;

```

보통 깊은 복사를 할 때엔 앞에서 다룬 **전개 연산자**를 사용한다.

```javascript

// 전개 연산자를 대괄호로 감싸야 한다.
const obj_200301 = ['우유', '식빵'];
const obj_200302 = [...obj_200301];

```

다음과 같이 배열을 전개하고 앞 또는 뒤에 자료를 추가하는 것도 가능하다.

```javascript

const obj_200302 = ['고구마', ...obj_200301, '토마토'];

```

## 객체 전개 연산자

객체를 깊은 복사할 때는 전개 연산자를 아래와 같은 형식으로 사용한다.

```javascript

const cloud = {
	name: 'cloud',
	age: 6,
	type: 'puppy'
}

const star = {...cloud};

```

배열의 경우와 마찬가지로 앞 뒤에 원하는 속성을 추가하는 것도 가능하다.

```javascript

const star = {
	...cloud,
	// 기존의 속성 덮어쓰기
	// ...cloud 가 맨 위에 위치하냐 아래에 위치하냐에 따라 덮어씌우는 서순이 다르다.
	name: 'star',
	// 새로운 속성 추가
	level: 45
}

```

# 문서 객체 조작하기

[[HTML]] 페이지에 있는 [[HTML 태그, 요소 그리고 속성 | 요소]]들을 자바스크립트에서는 ==문서 객체 document object==라고 부른다.

문서 객체를 조합해서 만든 전체적인 형태를 **문서 객체 모델 DOM, Document Objects Model**이라고 부른다.

## DOMContentLoaded 이벤트

자바스크립트는 문서 객체를 조작하여 동적으로 페이지를 변경시키는 일이 많다.
이때 DOMContentLoaded 이벤트를 사용한다.


```javascript

document.addListener('DOMContentLoaded', () => {
	// 문장
})

```

DOM을 사용할 때 주의해야 할 점이 있다. 기본적으로 HTML 태그는 위에서 아래 방향으로 순차적으로 생성되기 때문에 해당 태그가 생성되기 전에 DOM을 적용시키려고 하면 에러가 발생한다.

```html

<!DOCTYPE html>

<html>
<head>
	<title>DOMContentLoaded</title>
	<script>
		// HTML 태그를 쉽게 만들 수 있는 콜백 함수를 선언한다.
		const h1 = (text) => `<h1>{text}</h1>`
	</script>
	<script>
		// 앞에서 선언한 h1 함수를 실행한다.
		// body 태그가 생성되기 전 script 태그로 body 태그를 조작하므로 에러가 난다.
		document.body.innerHTML += h1('1번째 script 태그');
	</script>
</head>
<body>
	<script>
		document.body.innerHTML += h1('2번째 script 태그');
	</script>
	<h1>1번째 h1 태그</h1>
	<script>
		document.body.innerHTML += h1('3번째 script 태그');
	</script>
	<h1>2번째 h2 태그</h1>
</body>
</html>

```

**DOMContentLoaded** 이벤트는 웹 브라우저가 문서 객체를 모두 읽고 나서 실행되는 이벤트이다. 다음과 같이 코드를 구성하면 DOMContentLoaded 상태가 되었을 때 콜백 함수를 호출한다.

```html

<!DOCTYPE html>
<html>
<head>
	<title>DOMContentLoaded</title>
	<script>
		// DOMContentLoaded 이벤트를 연결한다.
		document.addEventListener('DOMContentLoaded', () => {
			const h1 = (text) => `<h1>${text}</h1>`;
			document.body.innerHTML += h1('DOMContentLoaded 이벤트 발생');
		})
	</script>
</head>
<body>
</body>
</html>

```

## 문서 객체 가져오기

document.body 코드를 사용하면 문서의 body 요소를 읽어들일 수 있다. 이외에도 HTML 문서에 있는 head 요소와 title 요소 등은 다음과 같은 방법으로 읽어들일 수 있다.

```javascript

document.body
document.head
document.title

```

이는 웹 브라우저의 자바스크립트가 '당연히 있겠지'라고 전제하고 만든 속성이다(그럴 일은 드물겠지만, html에 해당 태그를 만들어놓지 않으면 버그 난다는 소리다).

head, body 요소 내부에 있는 다른 요소들은 다음과 같은 별도의 메소드를 사용해서 접근한다.

```javascript

document.querySelector(선택자);
document.querySelectAll(선택자)

```

선택자 부분에는 [[CSS 선택자]]를 입력한다.

querySelector() 메소드는 요소를 하나만 추출하고, querySelectorAll() 메소드는 문서 객체를 여러 개 추출한다.

다음은 querySelector() 메소드를 사용해서 h1 태그를 추출하고 조작하는 예이다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		// 요소를 읽어들인다.
		// h1 태그 이름으로 요소를 선택한다.
		const header = document.querySelector('h1');

		// 텍스트와 스타일을 변경한다.
		header.textContent = 'HEADERS';
		header.style.color = 'white';
		header.style.backgroundColor = 'black';
		header.style.padding = '10px';
	});
</script>
<body>
	<h1><h1>
</body>

```

querySelectorAll()은 문서 객체 여러 개를 배열로 읽어들이는 함수이므로 내부의 요소에 전근하고 활용하려면 반복문을 활용해야 한다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		// 요소를 읽어들인다.
		const headers = document.querySelectorAll('h1');

		// 텍스트와 스타일을 변경한다.
		headers.forEach((header) => {
			header.textContent = 'HEADERS';
			header.style.color = 'white';
			header.style.backgroundColor = 'black';
			header.style.padding = '10px';
		})
	})
</script>
<body>
	<h1><h1>
	<h1><h1>
	<h1><h1>
	<h1><h1>
</body>

```

## 글자 조작하기

문서 객체 내부의 글자들을 조작할 때는 다음과 같은 메소드를 사용한다.

| 속성 이름            | 설명                                 |
| -------------------- | ------------------------------------ |
| 문서객체.textContent | 입력된 문자열을 그대로 넣는다        |
| 문서객체.innerHTML   | 입력된 문자열을 HTML 형식으로 넣는다 |

## 속성 조작하기

문서 객체의 속성을 조작할 때는 다음과 같은 메소드를 사용한다.

| 메소드 이름                          | 설명                      |
| ------------------------------------ | ------------------------- |
| 문서객체.setAttribute(속성 이름, 값) | 특정 속성에 값을 지정한다 |
| 문서객체.getAttribute(속성 이름)     | 특정 속성을 추출한다      |

다음 코드는 img 태그의 src 속성을 조작해서 이미지를 출력하는 예이다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		const rects = document.querySelector('.rect');
	
		rects.forEach((rect, index) => {
			const width = (index + 1) * 100;
			const src = `http://placecats.com/${width}/250`;
			// src 속성에 값을 지정한다
			rect.setAttribute('src', src);
		})
	})
</script>
<body>
	<img class="rect">
	<img class="rect">
	<img class="rect">
	<img class="rect">
</body>

```

get, setAttribute()를 사용하지 않고도 온점을 사용하여 문서 객체의 속성에 간단히 값을 지정할 수 있다.

```javascript

rects.forEach((rect, index) => {
	const width = (intex + 1) * 100;
	const src = `http://placecats.com/${width}/250`;
	rect.src = src;
})

```

## 스타일 조작하기

문서 객체의 스타일을 조작할 때는 style 속성을 사용한다. syle 속성은 객체이며, 내부에는 속성으로 CSS를 사용해서 지정할 수 있는 스타일들이 있다. 이러한 속성에는 CSS로 입력할 때 사용하는 값과 같은 값을 입력한다.

다만 자바스크립트에서 사용하는 속성들의 이름은 CSS에서 사용할 때의 속성들의 이름과 약간 다르다. 자바스크립트에서는 - 기호를 식별자에 사용할 수 없으므로, 두 단어 이상의 속성은 다음과 같이 캐멀 케이스로 나타낸다.

| CSS 속성 이름    | 자바스크립트 style 속성 이름 |
| ---------------- | ---------------------------- |
| background-color | backgroundColor              |
| text-align       | textAlign                    |
| font-size        | fontSize                     |

style 객체는 총 3가지 방법으로 스타일을 조정할 수 있다. 일반적으로 첫번째 방법을 가장 많이 사용한다.

```javascript

h1.style.backgroundColor;
h1.style['backgroundColor'];
h1.style['background-color'];

```

다음 코드는 25개의  div 태그를 조작해서 검은색에서 흰색으로 변화하는 그레이디언트를 만드는 코드이다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		// body 태그 아래에 있는 div 태그를 선택한다.
		const divs = document.querySelectorAll('body > div');
		
		divs.forEach(div, index) => {
			console.log(div, index);
			const val = index * 10;
			// 크기를 지정할 때는 반드시 단위를 함께 붙여줘야 한다.
			div.style.height = '10px';
			div.style.backgroundColor = `rgba${val}, ${val}, ${val}`
		}})
</script>
<body>
	<div></div><div></div><div></div>...
</body>

```

## 문서 객체 생성하기

 지금까지는 body 태그 내부에 특정 문서 객체를 읽어들이고 이를 조작하였다. 문서 객체를 생성하고 싶을 때에는 document.createElement() 메소드를 사용한다.

하지만 자바스크립트에서 문서 객체를 생성하는 것과 그 문서 객체를 어느 위치에 배치시킬 지 정하는 것은 별개의 작업이다.

어떠한 부모 객체 아래에 자식 객체를 추가하기 위해서  appendChild() 객체를 사용한다.

다음의 코드는 h1 태그를 새로 생성하고 이를 document.body의 자식으로 배치하는 코드이다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		// 문서 객체 생성하기
		// h1 태그를 생성한다.
		const header = document.createElement('h1');

		// 생성한 태그를 조작한다.
		header.textContent = '문서 객체 동적으로 생성하기';
		header.setAttribute('data-custom', '사용자 정의 속성');
		header.style.color = 'white';
		header.style.backgroundColor = 'black';

		// h1 태그를 body 태그 아래에 추가한다.
		document.body.appendChild(header);
	})
</script>
<body>
</body>

```

## 문서 객체의 이동

appendChild() 메소드는 문서 객체를 이동할 때도 사용할 수 있다. 문서 객체의 부모 parent는 언제나 하나여야 한다. 따라서 문서 객체를 다른 문서 객체에 추가하면 문서 객체가 이동한다.

다음 코드는 1초마다 h1 태그 요소가 div#first 태그와 div#second 태그 사이를 번갈아가며 움직이게 한다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		// 문서 객체 읽어들이고 생성하기
		const divA = document.querySelector('#first');
		const divB = document.querySelector('#second');
		const h1 = document.createElement('h1');
		h1.textContent = '이동하는 h1 태그';
	
		// 서로 번갈아가면서 실행하는 함수를 구현한다
		const toFirst = () => {
			// h1을 divA에 추가한다.
			divA.appendChild(h1);
			// 1초 뒤에 toSecond 함수를 실행한다.
			setTimeout(toSecond, 1000);
		}
		const toSecond = () => {
			// h1을 divA에 추가한다
			divA.appendChild(h1);
			// 10초 뒤에 toFirst 함수를 실행한다.
			setTimeout(toFirst, 10000);
		}
		toFirst();
	})
</script>
<body>
	<div id="first">
		<h1>첫 번째 div 태그 내부</h1>
	</div>
	<hr>
	<div id="second">
		<h1>두 번째 div 태그 내부</h1>
	</div>
</body>

```

## 문서 객체 제거하기

문서 객체를 제거할 때는 removeChild() 메소드를 사용한다.

```javascript

부모_객체.removeChild(자식_객체);

```

appendChild() 메소드 등으로 부모 객체와 이미 연결이 완료된 문서 객체의 경우 parentNode 속성으로 부모 객체에 접근할 수 있으므로, 일반적으로 어떤 문서 객체를 제거할 때는 다음과 같은 형태의 코드를 사용한다.

```javascript

문서_객체.parentNode.removeChild(문서_객체);

```

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		setTimeout(() => {
			const h1 = document.querySelector('h1');

			// h1 태그의 부모 객체 body 태그에 접근하여 제거한다.
			h1.parentNode.removeChild(h1);
			// h1.parentnode가 document.body이므로, 이런 형태로 제거할 수 있다
			// document.body.removeChild(h1);
		}, 3000)
	});
</script>
<body>
	<hr>
	<h1>제거 대상 문서 객체</h1>
	<hr>
</body>

```

# 이벤트 설정하기

지금까지 계속 documen.addEventListener('DOMConentLoaded', () => {})라는 형태의 코드를 사용하고 있다. 이 코드는 ==document라는 문서 객체의 DOMContentLoaded 이벤트가 발생했을 때, 매개변수로 지정한 콜백 함수를 실행해라==는 의미이다.

모든 문서 객체는 생성되거나 클릭되거나 마우스를 위에 올리거나 할 때 이벤트 event라는 것이 발생한다. 그리고 이 이벤트가 발생할 때 실행할 함수는 addEventListener() 메소드를 사용한다.

```javascript

문서_객체.addEventListener(이벤트_이름, 콜백_함수);

```

이벤트가 발생할 때 실행할 함수를 **이벤트 리스너 Event Listener** 또는 **이벤트 핸들러 Event Handler**라고 부른다. 어떤 이벤트가 있고, 어떤 형태로 활용하는지는 다음 절에서 살펴보기로 하고 이번 절에서는 이벤트를 연결하는 형태만 살펴본다.

다음 코드는 addEventListener() 메소드를 사용해서 h1 태그를 클릭할 때 이벤트 리스너(콜백 함수)를 호출하는 예이다. 이벤트 리스너 내부에서 변수 counter를 증가시키고 출력하고 있다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		let counter = 0;
		const h1 = document.querySelector('h1');

		h1.addEventListener('click', (event) => {
			// h1 태그에 이벤트가 발생할 때 실행할 함수
			counter++;
			h1.textContent = `클릭 횟수: ${counter}`;
		})
	})
</script>
<style>
	h1 {
		/*
			클릭을 여러 번 했을 때 글자가 선택되는 것을 막기 위한 스타일. 디자인 상 넣는 것이므로 안 넣어도 상관은 없다.
		*/
		user-select: none;
	}
</style>
<body>
	<h1>클릭 횟수: 0</h1>
</body>

```

이벤트 핸들러를 제거할 때는 다음과 같은 형태로 removeEventListener() 메소드를 사용한다.

`문서_객체.removeEventListener(이벤트 이름, 이벤트 리스너)`

이벤트 리스너 부분에 연결할 때 사용했던 이벤트 리스너를 넣는다.

# 이벤트 활용

## 이벤트 모델

이벤트를 연결하는 방법을 **이벤트 모델 event model**이라고 부른다. 이제껏 사용한 **addEventListener()**메소드는 현재 표준으로 사용하고 있는 방법이므로 **표준 이벤트 모델**이라고 부른다.

*고전 이벤트 모델과 인라인 모델에 관한 서술은 생략한다.*

## 키보드 이벤트

| 이벤트   | 설명                                                                       |
| -------- | -------------------------------------------------------------------------- |
| keydown  | 키가 눌릴 때 실행된다. 키보드를 꾹 누르고 있을 때도, 입력될 때고 실행된다. |
| keypress | 키가 입력되었을 때 실행된다.                                               |
| keyup    | 키보드에서 키가 떨어질 때 실행된다.                                        |

keydown 이벤트와 keypress 이벤트는 웹 브라우저에 따라서 아시아권의 문자(한국어, 중국어, 일본어)를 제대로 처리하지 못하는 문제가 있어서 일반적으로는 keyup 이벤트를 사용한다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		const textarea = document.querySelector('textarea');
		const h1 = document.querySelector('h1');

		textarea.addEventListener('keyup', (event) => {
			// value 속성으로 입력 양식의 글자를 읽어들일 수 있다.
			const length = textarea.value.length;
			h1.textContent = `글자 수: ${length}`;
		});
	})
</script>
<body>
	<h1></h1>
	<textarea></textarea>
</body>

```

## 키보드 키 코드 사용하기

키보드 이벤트가 발생할 때는 이벤트 객체로 어떤 키를 눌렀는지와 관련된 속성들이 따라온다. 주로 쓰이는 속성들은 다음과 같다.

| 이벤트 속성 이름 | 설명                      |
| ---------------- | ------------------------- |
| code             | 입력한 키                 |
| keyCode          | 입력한 키를 나타내는 숫자 |
| altKey           | alt 키를 눌렀는지         |
| ctrlKey          | ctrl 키를 눌렀는지        |
| shiftKey         | Shift 키를 눌렀는지       |

**code** 속성은 입력한 키를 나타내는 문자열이 들어있고, **altKey, ctrlKey, shiftKey** 속성은 해당 키를 눌렀는지 불 자료형 값이 들어있다.

다음 코드는 keydown 이벤트와 keyup 이벤트가 발생할 때 표에서 설명한 속성을 모두 출력하는 프로그램이다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		const h1 = document.querySelector('h1');
		const print = (event) => {
			let output = '';
			// 이벤트가 발생하면 불 값을 반환해야 한다.
			output += `alt: ${event.altKey}<br>`;
			output += `ctrl: ${event.ctrlKey}<br>`;
			output += `shift: ${event.shiftKey}<br>`;
			// event.code가 있으면 event.code를 출력하고, undefined라면 event.keyCode를 출력한다.
			output += `code: ${typeof(event.code) !== 'undefined' ?
				event.code : event.keyCode}<br>`
			h1.innerHTML = output;
		}

		// 키가 눌릴 때 출력한다
		document.addEventListener('keydown', print);
		// 키가 떨어질 때 출력한다
		document.addEventListener('keyup', print);
	});
</script>
<body>
	<h1></h1>
</body>

```


```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		// 별의 초기 설정
		const star = document.querySelector('h1');
		// style 속성을 조작하여 position 값을 설정한다
		star.style.position = 'absolute';

		// 별의 이동을 출력하는 기능
		let [x, y] = [0, 0];
		const block = 20;
		const print = () => {
			star.style.left = `${x * block}px`;
			star.style.top = `${y * block}px`;
		}
		print();

		// 별을 이동하는 기능
		const [left, up, right, down] = [37, 38 ,39 ,40];
		// 아시아권 문자를 사용하지 않으므로 keydown 이벤트를 사용해도 된다.
		document.body.addEventListener('keydown', (event) => {
			switch (event.keyCode)
			{
				case left:
					x -= 1;
					break ;
				case up:
					y -= 1;
					break ;
				case right:
					x += 1;
					break ;
				case down:
					y += 1;
					break ;
			}
			print();
		})

```

## 이벤트 발생 객체

지금까지는 이벤트 내부에서 문서 객체 변수를 사용해 문서 객체와 관련된 정보를 추출하였다.

```javascript

// 이전에 사용했던 코드
document.addEventListener('DOMContentLoaded', () => {
	const textarea = document.querySelector('textarea');
	const h1 = document.querySelector('h1');

	textarea.addEventListener('keyup', (event) => {
		// value 속성으로 입력 양식의 글자를 읽어들일 수 있다.
		const length = textarea.value.length;
		h1.textContent = `글자 수: ${length}`;
	})
})

```

그런데 코드의 규모가 켜지면 이벤트 리스너를 외부로 분리하는 경우가 많다. 상황에 따라서는 이벤트 리스너 내부에서 그러한 변수에 접근하지 못할 수 있다. 다음 코드에서는 listener() 함수 내부에서 textarea 변수에 접근할 수 없어 오류가 발생한다.

```javascript

// 이벤트 리스너를 외부로 빼낸 경우
const listener = (event) => {
	// scope 때문에 현재 블록에서는 textarea 변수를 사용할 수 없다.
	const length = textarea.value.length;
	h1.textContent = `글자 수 : ${length}`;
}

document.addEventListener('DOMContentLoaded', () => {
	const textarea = document.querySelector('textarea');
	const h1 = document.querySelector('h1');

	textarea.addEventListener('keyup', listener)
})

```

이러한 경우 이벤트를 발생시킨 객체(현재 코드의 textarea)에 접근할 수 있는 방법은 2가지이다.

방법 1. event.currentTarget 속성을 사용한다.

```javascript

// event.currentTarget이 textarea가 된다.
const listener = (event) => {
	const length = event.currentTarget.value.length;
	h1.textContent = `글자 수 : ${length}`;
}

document.addEventListener('DOMContentLoaded', () => {
	const textarea = document.querySelector('textarea');
	const h1 = document.querySelector('h1');

	textarea.addEventListener('keyup', listener)
})

```

방법 2. this 키워드를 사용한다

이 방법은 화살표 함수가 아닌 `function () {}` 형태로 함수를 선언한 경우에 사용한다.

```javascript

// this가 textarea가 된다.
const listener = (event) => {
	const length = this.value.length;
	h1.textContent = `글자 수 : ${length}`;
}

document.addEventListener('DOMContentLoaded', () => {
	const textarea = document.querySelector('textarea');
	const h1 = document.querySelector('h1');

	textarea.addEventListener('keyup', listener)
})

```

## 글자 입력 양식 이벤트

```html

<!--입력 양식을 기반으로 inch를 cm 단위로 변환하는 프로그램-->

<script>
	document.addEventListener('DOMContentLoaded', () => {
		const input = document.querySelector('input')
		const button = document.querySelector('button');
		const p = document.querySelector('p');

		button.addEventListener('click', () => {
			// 입력을 숫자로 변환한다
			const inch = Number(input.value);
			// 숫자가 아니라면 바로 리턴한다
			if (isNaN(inch))
			{
				p.textContent = '숫자를 입력해주세요.';
				return ;
			}
			// 변환해서 출력한다.
			const cm = inch * 2.54;
			p.textContent = `${cm} cm`;
		})
	})
</script>
<body>
	<input type="text"> inch<br>
	<button>계산</button>
	<p></p>
</body>

```

```html

<!--이메일 형식을 확인하기-->

<script>
	document.addEventListener('DOMContentLoaded', () => {
		const input = document.querySelector('input');
		const p = document.querySelector('p');
		// 이메일인지 검사하는 함수
		const isEmail = (value) => {
			// 골뱅이를 갖고 있고 && 골뱅이 뒤에 점이 있다면
			return (value.index('@') > 1)
				&& (value.split('@')[1].indexOf('.') > 1);
		}

		input.addEventListener('keyup', (event) => {
			const value = event.currentTarget.value;
			if (isEmail(value))
			{
				p.style.color = 'green';
				p.textContent = `이메일 형식입니다: ${value}`;
			}
			else
			{
				p.style.color = 'red';
				p.textContent = `이메일 형식이 아닙니다: ${value}`;
			}
		})
	})
</script>
<body>
	<input type="text">
	<p></p>
</body>

```

위의 이메일 확인 예제에서 유효성 검사를 할 때 문자열을 분석하는데, 차후 **정규 표현식 regular expression**을 사용하면 이러한 종류의 문제를 더욱 쉽게 해결할 수 있다.

> ### 글자 입력 양식의 change 이벤트
> 원래 입력 양식은 값이 변경될 때 change 이벤트를 발생한다. 글자 입력 양식은 입력 양식을 선택(focus 상태)해서 글자를 입력하고, 선택을 해제(blur 상태)할 때 change 이벤트를 발생시킨다. 따라서 사용자가 입력하는 중에는 change 이벤트가 발생하지 않는다. 지금까지 살펴본 코드는 값을 입력할 때 실시간으로 처리하고자 keyup 이벤트를 값을 입력할 때 실시간으로 처리하고자 keyup 이벤트를 사용하였다.

## 드롭다운 목록 활용하기

드롭다운 목록은 기본적으로 **select** 태그로 구현한다.

```html

<!--기본 select 태그-->
<script>
	document.addEventListener('DOMContentLoaded', () => {
		const select = document.querySelector(`select`);
		const p = document.querySelector('p');

		select.addEventListener('change', (event) => {
			const options = event.currentTarget.options;
			const index = options.selectedIndex;

			p.textContent = `선택: ${options[index].textContent}`;
		})
	})
</script>
<body>
	<select>
		<option>떡볶이</option>
		<option>순대</option>
		<option>오뎅</option>
		<option>튀김</option>
	</select>
	<p>선택: 떡볶이</p>
</body>

```

select 태그에 multiple 속성을 부여하면 ctrl 키 또는 shift 키를 누르고 여러 항목을 선택할 수 있는 선택 상자가 나온다.

```html

<!--multiple select 태그-->
<script>
	document.addEventListener('DOMContentLoaded', () => {
		const select = document.querySelector(`select`);
		const p = document.querySelector('p');

		select.addEventListener('change', (event) => {
			const options = event.currentTarget.options;
			const list = [];
			// options 속성에는 forEach() 메소드가 없으므로 반복문으로 돌려야 한다.
			for (const option of options)
			{
				if (option.selected)
				{
					list.push(option.textContent);
				}
			}
			p.textContent = `선택: ${list.join(',')}`;
		})
	})
</script>
<body>
	<select>
		<option>떡볶이</option>
		<option>순대</option>
		<option>오뎅</option>
		<option>튀김</option>
	</select>
	<p>선택: 떡볶이</p>
</body>

```

## 체그 박스 활용하기

체크 박스처럼 체크 상태를 확인할 때는 입력 양식의 checked 속성을 활용한다.


```html

<!--체크 상태일 때만 타이머를 증가시키는 프로그램-->
<script>
	document.addEventListener('DOMContentLoaded', () => {
		let [timer, timerId] = [0, 0];
		const h1 = document.querySelector('h1');
		const checkbox = document.querySelector('input');

		checkbox.addEventListener('change', (event) => {
			if (event.currentTarget.checked)
			{
				// checked 속성을 사용한다.
				if (event.currentTarget.checked)
				{
					// 체크 상태
					timerId = setInterval(() => {
						timer += 1;
						h1.textContent = `${timer}초`
					}, 1 * 1000);
				}
				else
				{
					// 체크 해제 상태
					clearInterval(timerId);
				}
			}
		})
	})
</script>
<body>
	<input type="checkbox">
	<span>타이머 활성화</span>
	<h1></h1>
</body>

```

## 라디오 버튼 활용하기

라디오 버튼은 여러 개의 선택지 중에 하나의 요소를 checked 속성을 사용하여 선택할 수 있게 해주는 옵션이다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		// 문서 객체 추출하기
		const output = document.querySelector('#output');
		const radios = document.querySelectorAll('[name=pet]');

		// 모든 라디오 버튼에
		radios.forEach((radio) => {
			// 이벤트 연결
			radio.addEventListener('change', (event) => {
				const current = event.currentTarget;
				if (current.checked)
				{
					output.textContent = `좋아하는 애완동물은 ${current.value}이시군요!`;
				}
			})
		})
	})
</script>
<body>
	<h3># 좋아하는 애완동물을 선택해주세요</h3>
	<!--라디오 버튼을 하나씩만 선택하려면 name 속성을 동일하게 입력해 그룹으로 만든다.-->
	<input type="radio" name="pet" value="강아지">
	<span>강아지</span>
	<input type="radio" name="pet" value="고양이">
	<span>고양이</span>
	<input type="radio" name="pet" value="햄스터">
	<span>햄스터</span>
	<input type="radio" name="pet" value="기타">
	<span>기타</span>
	<hr>
	<h3 id="output"></h3>
</body>

```

> name 속성이 없는 라디오 버튼
> 참고로 name 속성을 입력하지 않으면 라디오 버튼을 한번에 여러 개 선택할 수 있다. 카테고리 구분 없이 선택할 수 있으며, 한번 선택하고 나면 선택을 취소할 수도 없다.
> 따라서 라디오 버튼을 사용할 때는 name 속성과 함께 사용하는 것이 좋다.

## 기본 이벤트 막기

웹 브라우저에서 마우스 오른쪽 버튼을 클릭하면 출력되는 메뉴를 **컨텍스트 메뉴 context menu**라고 한다.
이처럼 어떤 이벤트가 발생했을 때 웹 브라우저가 기본적으로 처리해주는 것을 **기본 이벤트**라고 부른다.

링크를 클릭했을 때 이동하는 것, 제출 버튼을 눌렀을 때 이동하는 것 등이 모두 기본 이벤트의 예이다. 이러한 기본 이벤트를 제거할 때는 event 객체의 preventDefault() 메소드를 사용한다.

```html

<script>
	document.addEventListener('DOMContentLoaded' () => {
		const imgs = document.querySelectorAll('img');

		imgs.forEach((img) => {
			img.addEventListener('contextmenu', (event) => {
				// 컨텍스트 메뉴를 출력하는 기본 이벤트를 제거한다.
				event.preventDefault();
			})
		})
	})
</script>
<body>
	<img src="http://placecats.com/300/300" alt="">
</body>

```

인터넷에서 이미지 불펌 방지 등을 구현할 때 사용하는 코드이므로 기억해두면 유용하게 활용할 수 있다.

```html

<!--다른 입력 양식과 조합해서 사용하는 예
	체크 때만 링크 활성화하기-->

<script>
	document.addEventListener('DOMContentLoaded', () => {
		let status = false;

		const checkbox = document.querySelector('input');
		checkbox.addEventListener('change', (event) => {
			status = event.currentTarget.checked;
		});

		const link = document.querySelector('a');
		lint.addEventListener('click', (event) => {
			if (!status)
			{
				// status가 false가 아니면 링크의 기본 이벤트를 제거한다
				event.preventDefault()
			}
		})
	})
</script>
<body>
	<input type="checkbox">
	<span>링크 활성화</span>
	<br>
	<a href="http://hanbit.co.kr">한빛미디어</a>
</body>

```

## 타이머로 구현한 남은 글자 수 세기

아시아권의 문자는 키보드 이벤트로 원하는 것을 제대로 구현할 수 없는 경우가 많다.

실제로 트위터는 아래 코드와 같이 타이머를 사용해서 50밀리초마다 입력 양식 내부의 글자를 확인해서 글자 수를 센다. **focus** 이벤트와 **blur** 이벤트를 활용하였다.

```html

<script>
	document.addEventListener('DOMContentLoaded', () => {
		const textarea = document.querySelector('textarea');
		const h1 = document.querySelector('h1');
		let timerId;

		textarea.addEventListener('focus', (event) => {
			// 입력 양식 활성화
			timerId = setInterval(() => {
				const length = textarea.value.length;
				h1.textContent = `글자 수: ${length}`;
			}, 50)
		})
		textarea.addEventListener('blur', (event) => {
			// 입력 양식 비활성화
			clearInterval(timerId);
		})
	})
</script>
<body>
	<h1></h1>
	<textarea></textarea>
</body>

```

# localStorage

**localStorage 객체**는 웹 브라우저가 기본적으로 제공하는 객체이며, 데이터를 저장하고 반환하는 기능을 가지고 있다.

아래와 같은 메소드를 가지고 있다.

- localStorage.getItem(키) : 저장된 값을 추출한다. 없으면 undefined가 나온다. 객체의 속성을 추출하는 일반적인 형태로 localStorage.키 또는 localStorage\[키] 형태로 사용할 수도 있다.
- localStorage.setItem(키, 값) : 값을 저장한다. 이전과 마찬가지로 객체에 속성을 지정하는 일반적인 형태를 사용할 수도 있다.
- localStorage.removeItem(키) : 특정 키의 값을 제거한다.
- localStorage.clear() : 저장된 모든 값을 제거한다.

```html

<!--localStorage 객체의 활용-->
<script>
	document.addEventListener('DOMContentLoaded', () => {
		const p = document.querySelector('p');
		const input = document.querySelector('input');
		const button = document.querySelector('button');

		// 값을 읽을 때는 getItem() 메소드를 사용한다.
		const savedValue = localStorage.getItem('input');
		// localStorage.input도 가능하다.
		if (savedValue)
		{
			input.value = savedValue;
			p.textContent = `이전 실행 때의 마지막 값: ${savedValue}`;
		}

		input.addEventListener('keyup', (event) => {
			const value = event.currentTarget.value;
			localStorage.setItem('input', value);
		})

		button.addEventListener('click', (event) => {
			localStorage.clear();
			input.value = '';
		})
	})
</script>
<body>
	<p></p>
	<button>지우기</button>
	<input type="text">
</body>

```

# 구문 오류와 예외

자바스크립트의 오류는 2가지로 나뉜다.

**구문 오류 syntax error**: 괄호 개수를 잘못 입력하는 등의 오류로 코드가 실행조차 되지 않는 오류
**예외 exception, 런타임 오류 runtime error** : 구문 오류를 제외하고 코드 실행 중간에 발생하는 오류(반대로 말하면, 코드 실행까지는 어떻게든 된다는 소리다.)

## 고급 예외 처리 - try catch finally 구문

자바스크립트의 try catch finally 구문은 c++의 try catch 구문과 유사하다. 다만, finally 구문은 예외가 발생하는지와 상관없이 무조건 실행된다는 차이점이 있다.

참고로, finally 구문은 필수적이지 않으므로 생략해도 무방하다.

```javascript

function test () {
	try
	{
		// nothing.nothing() -> nothing이라는 객체의 nothing
		alert('A 위치');
		// throw 키워드로 예외를 강제로 발생시킨다
		throw "예외 강제 발생";
	}
	catch (exception)
	{
		alert('B 위치');
		return ;
	}
	alert('C 위치');
}

// 함수를 호출
test();

```

```javascript

function test () {
	try
	{
		// nothing.nothing() -> nothing이라는 객체의 nothing
		alert('A 위치');
		// throw 키워드로 예외를 강제로 발생시킨다
		throw "예외 강제 발생";
	}
	catch (exception)
	{
		alert('B 위치');
		return ;
	}
	finally
	{
		alert('C 위치');
	}
}

// 함수를 호출
test();

```

finally 구문의 ==반드시 실행된다==는 특성은 매우 강력하기 때문에, 다음과 같은 경우에조차 실행이 보장된다.

- try catch 구문 내부에서 return 키워드를 만날 때
- try catch 구문 내부에서 break 또는 continue 키워드를 만날 때

> catch 의 괄호 안의 인자를 **예외 객체 exception object**라고 한다. 아무 식별자나 입력해도 괜찮지만, 일반적으로 e나  exception이라는 식별자를 사용한다.

throw는 다음과 같은 방식으로 조금 다르게 실행시킬 수 있다. 한 번 직접 실행해보도록 하자.

```javascript

// 단순하게 예외를 발생시킨다
throw 문자열;

// 조금 더 자세하게 예외를 발생시킨다
throw new Error(문자열);

```

> 자바스크립트는 다른 프로그래밍 언어면 퉤퉤할 것도 꾸역꾸역 실행시키기 때문에 예외 처리가 좀 더 중요해보입니다 by sihong

# 클래스

*클래스에 관해서는 별 거 없기 때문에 기본적인 문법으로 설명합니다.*
*클래스에 관해서는 c++과 유사한 문법이 많습니다*

js 개발자들은 크게 **클래스 class**와 **프로토타입 prototype**이라는 2가지 문법으로 객체를 효율적으로 만들 수 있게 하였다. 간단하게 구분하면 클래스는 객체를 만들 때 수많은 지원을 하는 대신 많은 제한을 거는 문법이다. 반면 프로토타입은 제한을 많이 하지 않지만, 대신 지원도 별로 하지 않는 문법이다.

> 프로토타입은 고대의 js에서나 쓰던 문법이므로 생략합니다.

클래스는 다음과 같은 형태로 생성한다.

```javascript

class ClassName {
	...
}

```

객체는 new 키워드를 사용하여 생성한다.

> c class 언어와 달리 별도로 동적 메모리 관리를 할 필요가 없다.
> js에서도 클래스의 첫 글자는 대문자로 하는 것이 규약이다.

```javascript

new ClassName();

```

## 생성자

자바스크립트에서는 생성자만 존재하고 소멸자 desturctor만 존재한다.

> 사변 피셜 그래서 소멸자 역할을 하는 함수를 만들어서 수동으로 호출하는 식으로 처리한다 합니다.

```javascript

class Student
{
	constructor () {
		/* 생성자 코드 예시 */
		this.이름 = 이름;
		this.국어 = 국어;
		this.영어 = 영어;
		this.수학 = 수학;
		this.과학 = 과학;
	}
}

```

## 메소드

클래스의 메소드는 객체의 메소드와 달리 내부적으로 중복되지 않고 하나만 생성된다.

*따라서 쥐꼬리만큼이라도 성능을 끌어올리고 싶다면 여러 번 중복되는 것들은 객체보다 클래스를 활용하는 것이 좋다.*

```javascript

class Student
{
	// 중략
	
	// 아래와 같은 형식으로 선언한다. 객체에서 간단한 형식으로 메소드를 선언하는 것과 동일하다.
	getSum ()
	{
		return this.국어 + this.영어 + this.수학 + this.과학;
	}
}

```

# 클래스 고급

## 상속

상속 문법

```javascript

class ClassName extends ParentClass
{
	...
}

```

자식의 생성자는 **super** 키워드를 사용하여 부모의 생성자 코드를 호출한다.

```javascript

class Rectangle
{
	constructor (width, height)
	{
		this.width = width;
		this.height = height;
	}
}

class Square extends Rectangle
{
	constructor (length) {
		super(length, length);
	}
}

```

## 클래스 속성

클래스의 메소드 혹은 멤버를 private하게 선언하고 싶다면 맨 앞에 *#*을 붙이면 된다.

```javascript

class Example
{
	#privateMember

	#privateMethod () {}
}

```

게터와 세터에 관해서는 생략

## get 키워드와 set 키워드

get 키워드와 set 키워드는 게터 세터를 좀 더 편리하게 선언하기 위한 문법적인 요소이다.

```javascript

class Square
{
	#length

	constructor (length)
	{
		this.length = length;
	}

	// 참고로 get 키워드를 이용해 만든 객체는 어떠한 인자도 받지 못한다.
	get length ()
	{
		return this.#length;
	}

	get perimeter ()
	{
		return this.#length * 4;
	}

	set length (length)
}

// 클래스 사용하기
const squareA = new Square(10);
// .length로 접근하면 get length가 호출된다
console.log(`한 변의 길이: ${squareA.length}`);
console.log(`둘레: ${squareA.perimeter}`);
// .length로 값을 넣으면 set length가 호출된다.
squareA.length = 10;

```

# static 속성과 메소드

**static 키워드**로 선언된 클래스의 멤버와 메소드는 클래스를 생성하지 않아도 사용할 수 있다 (c++과 동일하다.)

```javascript

class ClassName {
	static member = value;
	static method () {
		...
	}
}

// 아래와 같이 사용
ClassName.member;
ClassName.method();

```

# 오버라이드

부모가 선언한 함수를 자식이 똑같은 이름으로 선언해서 덮어쓰는 것.

```javascript

class LifeCycle
{
	a () { console.log("부모의 a 메소드입니다.") }
}

class Child
{
	a () { console.log("자식의 a 메소드입니다.") }
}

// 부모 객체를 호출하면 부모의 a가, 자식 객체를 호출하면 자식의 a가 호출된다.

```

---

참고자료

#참고도서/혼자_공부하는_자바스크립트 

---

