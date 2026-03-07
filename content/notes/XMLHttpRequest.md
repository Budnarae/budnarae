
---

#language/JavaScript #web 

_서버와의 통신_

---

# XMLHttpRequest

브라우저는 주소창이나 HTML의 form 태그 또는 a 태그를 통해 HTTP 요청 전송 기능을 기본 제공한다. 자바스크립트를 사용하여 HTTP 요청을 전송하려면 XMLHTTPRequest 객체를 사용한다. Web API인 XMLHttpRequest 객체는 HTTP 요청 전송과 HTTP 응답 수신을 위한 다양한 메서드와 프로퍼티를 제공한다.

## XMLHttpRequest 객체 생성

XMLHttpRequest 객체는 XMLHttpRequest 생성자 함수를 호출하여 생성한다. XMLHttpRequest 객체는 브라우저에서 제공하는 Web API이므로 브라우저 환경에서만 정상적으로 실행된다.

```javascript

// XMLHttpRequest 객체의 생성
const xhr = new XMLHttpRequest();

```

## XMLHTTPRequest 객체의 프로퍼티와 메서드

XMLHttpRequest 객체는 다양한 프로퍼티와 메서드를 제공한다. 대표적인 프로퍼티와 메서드는 다음과 같다. 중요한 프로퍼티와 메서드는 볼드체로 표시했다.

### XMLHttpRequest 객체의 프로토타입 프로퍼티

#### readyState

HTTP 요청의 현재 상태를 나타내는 정수. 다음과 같은 XMLHttpRequest의 정적 프로퍼티를 값으로 갖는다.

- UNSENT: 0
- OPENED: 1
- HEADERS_RECEIVED: 2
- LOADING: 3
- DONE: 4

#### status

HTTP 요청에 대한 응답 상태(HTTP 상태 코드)를 나타내는 정수
ex) 200

#### statusText

HTTP 요청에 대한 응답 메시지를 나타내는 문자열
ex) "OK"

#### responseType

HTTP 응답 타입
ex) document, json, text, blob, arraybuffer

#### response

HTTP 요청에 대한 응답 몸체 reponse body. reponseType에 따라 타입이 다르다.

#### reponseText

서버가 전송한 HTTP 요청에 대한 응답 문자열

### XMLHttpRequest 객체의 이벤트 핸들러 프로퍼티
### XMLHttpRequest 객체의 메서드
### XMLHttpRequest 객체의 정적 프로퍼티

(추후 보충)

## HTTP 요청 전송

HTTP 요청을 전송하는 경우 다음 순서를 따른다.

1. XMLHttpRequest.prototype.open 메서드로 HTTP 요청을 초기화한다.
2. 필요에 따라 XMLHttpRequest.prototype.setRequestHeader 메서드로 특정 HTTP 요청의 헤더 값을 설정한다.
3. XMLHttpRequest.prototype.send 메서드로 HTTP 요청을 전송한다.

```javascript

// XMLHttpRequest 객체 생성
const xhr = new XMLHttpRequest();

// HTTP 요청 초기화
xhr.open('GET', '/users');

// HTTP 요청 헤더 설정
// 클라이언트가 서버로 전송할 데이터의 MIME 타입 지정: json
xhr.setRequestHeader('content-type', 'application/json');

// HTTP 요청 전송
xhr.send();

```

### XMLHttpRequest.prototype.open

open 메서드는 서버에 전송할 HTTP 요청을 초기화한다. open 메서드를 호출하는 방법은 다음과 같다. 

```javascript

xhr.open(method, url[, async]);

```

| 매개변수 | 설명                                                                    |
| -------- | ----------------------------------------------------------------------- |
| method   | HTTP 요청 메서드("GET", "POST", "PUT", "DELETE" 등)                     |
| url      | HTTP 요청을 전송할 URL                                                  |
| async    | 비동기 요청 여부. 옵션으로 기본값은 true이며, 비동기 방식으로 동작한다. |

HTTP 요청 메서드는 클라이언트가 서버에게 요청의 종류와 목적(리소스에 대한 행위)을 알리는 방법이다.
주로 5가지 요청 메서드(**GET, POST, PUT, PATCH, DELETE 등**)을 사용하여 CRUD를 구현하다.

| HTTP 요청 메서드 | 종류           | 목적                  | 페이로드 |
| ---------------- | -------------- | --------------------- | -------- |
| GET              | index/retrieve | 모든/특정 리소스 취득 | X        |
| POST             | create         | 리소스 생성           | O        |
| PUT              | replace        | 리소스의 전체 교체    | O        |
| PATCH            | modify         | 리소스의 일부 수정    | O        |
| DELETE           | delete         | 모든/특정 리소스 삭제 | X         |

### XMLHttpRequest.prototype.send

send 메서드는ㄴ open 메서드로 초기화된 HTTP 요청을 서버에 전송한다. 기본적으로 서버로 전송하는 데이터는 GET, POST 요청 메서드에 따라 전송 방식에 차이가 있다.

- GET 요청 메서드의 경우 데이터를 URL의 일부분인 쿼리 문자열 query string로 서버에 전송한다.
- POST 요청 메서드의 경우 데이터(페이로드 payload)를 요청 몸체 request body에 담아 전송한다.

send 메서드에는 요청 몸체에 담아 전송할 데이터(페이로드)를 인수로 전달할 수 있다. 페이로드가 객체인 경우 반드시 JSON.stringify 메서드를 사용하여 직렬화한 다음 전달해야 한다.

```javascript

xhr.send(JSON.stringify({ id: 1, content: 'HTML', conpleted: false }));

```

==HTTP 요청 메서드가 GET인 경우 send 메서드에 페이로드로 전달한 인수는 무시되고 요청 몸체는 null로 설정된다.==

### XMLHttpRequest.prototype.setRequestHeader

setRequestHeader 메서드는 특정 HTTP 요청의 헤더 값을 설정한다. setRequestHeader 메서드는 반드시 open 메서드를 호출한 이후에 호출해야 한다. 자주 사용하는 HTTP 요청 헤더인 Content-type과 Accept에 대해 살펴보자.

Content-type은 요청 몸체에 담아 전송할 데이터의 MIME 타입의 정보를 표현한다. 자주 사용되는 MIME 타입은 다음과 같다.

| MIME 타입   | 서브타입                                           |
| ----------- | -------------------------------------------------- |
| text        | text/plane, text/html, text/css, text/javascript   |
| application | application/json, application/x-www-form-urlencode |
| multipart   | multipart/formed-data                              |

다음은 요청 몸체에 담아 서버로 전송할 페이로드의 MIME 타입을 지정하는 예다.

```javascript

// XMLHttpRequest 객체 생성
const xhr = new XMLHttpRequest();

// HTTP 요청 초기화
xhr.open('POST', '/users');

// HTTP 요청 헤더 설정
// 클라이언트가 서버로 전송할 데이터의 MIME 타입 지정: json
xhr.setRequestHeader('content-type', 'application/json');

// HTTP 요청 전송
xhr.send(JSON.stringify({ id: 1, content: 'HTML', completed: false }));

```

HTTP 클라이언트가 서버에 요청할 때 서버가 응답할 데이터의 MIME 타입을 Accept로 지정할 수 있다. 다음은 서버가 응답할 데이터의 MIME 타입을 지정하는 예다.

```javascript

// 서버가 응답할 데이터의 MIME 타입 지정: json
xhr.setRequestHeader('accept', 'application/json');

```

만약 Accept 헤더를 설정하지 않으면 send 메서드가 호출될 때 Accept 헤더가 \*/\*으로 전송된다.

## HTTP 응답 처리

서버가 전송한 응답을 처리하려면 XMLHttpRequest 객체가 발생시키는 이벤트를 캐치해야 한다.

상술했듯이 XMLHttpRequest 객체는 onreadystate, onload, onerror 같은 이벤트 핸들러 프로퍼티를 갖는다. 이 이벤트 핸들러 프로퍼티 중에서 HTTP 요청의 현재 상태를 나타내는 readyState 프로퍼티 값이 변경된 경우 발생하는 readyStatechange 이벤트를 캐치하여 다음과 같이 HTTP 응답을 처리할 수 있다.

참고로 HTTP 요청을 전송하고 응답을 받으려면 서버가 필요하다. 다음 예제에서는 JSONPlaceholder에서 제공하는 가상 (fake) REST API를 사용한다.

```javascript

// XMLHttpRequest 객체 생성
const xhr = new XMLHttpRequest();

// HTTP 요청 초기화
// https://jsonplaceholder.typicode.com은 Fake REST API를 제공하는 서비스다.
xhr.open('GET', 'https://jsonplaceholder.typicode.com/todos/1');

// HTTP 요청 전송
xhr.send();

// readystatechange 이벤트는 HTTP 요청의 현재 상태를 나타내는
// readyState 프로퍼티가 변경될 때마다 발생한다.
xhr.onreadystatechange = () => {
	// readyState 프로퍼티는 HTTP 요청의 현재 상태를 나타낸다.
	// readyState 프로퍼티 값이 4(XMLHttpRequest.DONE)가 아니면 서버 응답이 완료되지 않은 상태다.
	// 만약 서버 응답이 아직 완료되지 않았다면 아무런 처리를 하지 않는다.
	if (xhr.readyState !== XMLHttpRequest.DONE) return;

	// status 프로퍼티는 응답 상태 코드를 나타낸다.
	// status 프로퍼티 값이 200이면 정상적으로 응답된 상태이고
	// status 프로퍼티 값이 200이 아니면 에러가 발생한 상태다.
	// 정상적으로 응답된 상태라면 response 프로퍼티에 서버의 응답 결과가 담겨 있다.
	if (xhr.status === 200)
	{
		console.log(JSON.parse(xhr.reponse));
	}
	else
	{
		console.error('Error', xhr.status, xhr.statusText);
	}
};

```

---

참고자료

#참고도서/모던_자바스크립트_Deep_Dive 

---
