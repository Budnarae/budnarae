
---

#language/JavaScript #web 

_neo XMLHttpRequest_

---

# fetch

fetch 함수는 [[XMLHttpRequest]] 객체와 마찬가지로 HTTP 요청 전송 기능을 제공하는 클라이언트 사이드 Web API이다. fetch 함수는 XMLHttpRequest 객체보다 사용법이 간단하고 프로미스를 지원하기 때문에 비동기 처리를 위한 콜백 패턴의 단점에서 자유롭다.

fetch 함수에는 HTTP 요청을 전송할 URL과 HTTP 요청 메서드, HTTP 요청 헤더, 페이로드 등을 설정한 객체를 전달한다.

```javascript

const promise = fetch(url [, options]);

```

==fetch 함수는 HTTP 응답을 나타내는 Response 객체를 래핑한 Promise 객체를 반환한다.== fetch 함수로 GET 요청을 전송해 보자. fetch 함수에 첫 번째 인수로 HTTP 요청을 전송할 URL만 전달하면 GET 요청을 전송한다.

```javascript

fetch('https://jsonplaceholder.typicode.com/todos/1')
	.then(response => console.log(response));

```

fetch 함수는 HTTP 응답을 나타내는 Response 객체를 래핑한 프로미스를 반환하므로 후속 처리 메서드 then을 통해 프로미스가 resolve한 Response 객체를 전달받을 수 있다. Response 객체는 HTTP 응답을 나타내는 다양한 프로퍼티를 제공한다.

Response.prototype에는 Response 객체에 포함되어 있는 HTTP 응답 몸체를 위한 다양한 메서드를 제공한다. 예를 들어, fetch 함수가 반환한 프로미스가 래핑하고 있는 MIME 타입이 application/json인 HTTP 응답 몸체를 취득하려면 Response.prototype.json 메서드를 사용한다. 

Response.prototype.json 메서드는 Response 객체에서 **HTTP 응답 몸체 response.body**를 취득하여 역직렬화한다.

```javascript

fetch('https://jsonplaceholder.typicode.com/todos/1')
	// response는 HTTP 응답을 나타내는 Response 객체다.
	// json 메서드를 사용하여 Response 객체에서 HTTP 응답 몸체를 취득하여 역직렬화한다.
	.then(response => response.json())
	// json은 역직렬화된 HTTP 응답 몸체다.
	.then(json => console.log(json));

```

fetch 함수를 통해 HTTP 요청을 전송해보자. fetch 함수에 첫 번째 인수로 HTTP 요청을 전송할 URL과 두 번째 인수로 HTTP 요청 메서드, HTTP 요청 헤더, 페이로드 등을 설정한 객체를 전달한다.

```javascript

const request = {
    get(url) {
        return fetch(url);
    },
    post(url, payload) {
        return fetch(url, {
            method: 'POST',
            headers: { 'content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
    },
    patch(url, payload) {
        return fetch(url, {
            method: 'PATCH',
            headers: { 'content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
    },
    delete(url) {
        return fetch(url, { method: 'DELETE' });
    }
}

// GET 요청
request.get('https://jsonplaceholder.typicode.com/todos/1')
    .then(response => response.json())
    .then(todos => console.log(todos))
    .catch(err => console.error(err));

// POST 요청
request.post('https://jsonplaceholder.typicode.com/todos', {
    userId: 1,
    title: 'JavaScript',
    completed: false
}).then(response => response.json())
    .then(todos => console.log(todos))
    .catch(err => console.error(err));

// PATCH 요청
request.post('https://jsonplaceholder.typicode.com/todos/1', {
    completed: true
}).then(response => response.json())
    .then(todos => console.log(todos))
    .catch(err => console.error(err));

// DELETE 요청
request.delete('https://jsonplaceholder.typicode.com/todos/1')
    .then(response => response.json())
    .then(todos => console.log(todos))
    .catch(err => console.error(err));

```

더 자세한 내용은 [다음](https://developer.mozilla.org/ko/docs/Web/API/Fetch_API/Fetch의_사용법)을 참고하자.

---

참고자료

#참고도서/모던_자바스크립트_Deep_Dive 

---
