---
title: 'Json Web Token'
tags:
  - 'security'
  - 'cryptograph'
  - 'web'
---

<iframe width="787" height="443" src="https://www.youtube.com/embed/36lpDzQzVXs" title="JWT" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

**JWT**는 Json Web Token의 약자이다. 자료를 [[JSON]] 형태로 다른 장치에게 안전하게 전송하기 위한 프로토콜이다.

JWT는 다음의 세 가지 요소로 이루어져 있다.

1. 헤더 header : "alg"(알고리즘의 약자)와 "typ"이라는 두 개의 프로퍼티로 구성되어있다. alg 프로퍼티에는 서명을 어떠한 알고리즘으로 암호화했는지를 저장한다.
2. 페이로드 payload : 실질적인 내용을 저장하는 부분이다. payload의 각 부분을 claim(주장)이라고 하는데, 이는 받는 입장에서 payload의 내용을 완전히 신뢰할 수 없기 때문이다.
3. 서명 signature : 페이로드의 내용을 보증하는 보안적 요소

JWT 토큰은 누군가에게 갈취당하더라도 아무나 해독하지 못하도록 base64라는 방식으로 인코딩되어 전송된다.

JWT는 다음과 같은 방식으로 사용된다.

1. JWT 토큰을 작성하여 보내는 측은(예를 들어, 웹 서버라고 하자) 본문(페이로드)를 작성한 후 특정한 암호화 알고리즘과(HMAC을 썼다고 가정하자) private 키를 사용하여 본문을 암호화하여 서명을 작성한다. HMAC 알고리즘을 사용하였으므로 토큰의 헤더 부분이 HMAC 알고리즘이 사용되었음이 기록된다.
2. JWT 토큰을 받은 프론트 측은 긴 시간이 지난 후 웹 서버에게 자신을 인증하기 위해 해당 토큰을 다시 웹 서버에게 보낸다.
3. 토큰의 헤더의 HMAC 알고리즘이 저장되어 있으므로 웹 서버는 HMAC 알고리즘을 불러와 가지고 있는 private 키와 토큰의 페이로드를 사용하여 새로운 서명을 만든다.
4. 새로 만든 서명이 토큰의 서명과 일치한다면 서버는 토큰이 자신이 발행한 것이라고 확신할 수 있다.

# JWT의 활용

1. ==인증 Authentication==
2. 정보 공유 Information Exchange
3. 권한 부여 Authorization
4. 단일 로그인 Single Sign-On
5. 서버 간 통신 Server-to-server communication

가장 주된 활용처는 **로그인 기능**을 구현할 때 인증에 사용되는 것이다.

# 쿠키 기반의 세션 인증 vs JWT

세션 id의 단점은 다음과 같다.

1. 세션 기반의 인증은 특정한 작업을 할 때마다 서버에 세션 id를 확인 받아야 한다. 서버가 해당 세션 id가 유효한지 확인하기 위해서는 세션 id가 저장된 db를 싹 다 순회해야 하므로 추가 비용이 발생한다.
2. 세션 id에는 사용자의 개인 정보가 포함되어 있지 않기 때문에 해당 정보가 필요하다면 서버에 다시 요청해야 한다.
3. 사용자가 새로운 기기로 접속할 때마다 쿠키를 다시 발행해야 한다.

반면에 JWT는 다음과 같은 절차를 거친다.

1. 사용자가 서버에 로그인을 요청한다.
2. 서버는 db를 조회해 해당 사용자가 실제로 존재하는지 확인한다. 확인이 끝나면 해당 사용자에게 JWT 토큰을 발행한다.
3. 사용자는 페이로드를 통해 사용자 정보를 전달받을 수 있기 때문에 서버에 다시 요청할 필요가 없다.(쿠키 기반 세션 인증의 2번째 단점 해결)
4. 사용자가 서버에 특정 요청을 다시 할 때 서버는 토큰의 서명을 대조하는 것만으로 진위를 확인할 수 있으므로 db를 조회하지 않아도 된다(쿠키 기반 세션 인증의 1번째 단점 해결 )

---

참고자료

#참고링크/생활코딩 

---

