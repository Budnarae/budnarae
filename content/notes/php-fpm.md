---
title: 'php-fpm'
---

**php-fpm**은 다음의 특징을 가진 **FastCGI(fast common gateway interface)** 솔루션이다.

- 적응형 프로세스 생성
- 기본 통계(아파치의 mod_status와 유사)
- 우아한 종료/시작을 지원하는 향상된 프로세스 관리
- 다른 uid/gid/chroot/environment 및 다른 php.ini로 작업자를 시작할 수 있는 기능(safe_mode를 대체)
- Stdout 및 stderr 로깅
- 실수로 opcode 캐시가 파괴된 경우 긴급 재시작
- 가속 업로드 지원
- "slowlog" 지원
- FastCGI에 추가된 fastcgi_finish_request() 기능은 시간이 많이 걸리는 작업(비디오 변환, 통계 처리 등)을 계속 진행하면서 요청을 완료하고 모든 데이터를 플러시하는 특수 기능입니다.

# CGI란

[위키백과](https://ko.wikipedia.org/wiki/%EA%B3%B5%EC%9A%A9_%EA%B2%8C%EC%9D%B4%ED%8A%B8%EC%9B%A8%EC%9D%B4_%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4)
[IBM 홈페이지](https://www.ibm.com/docs/ko/i/7.5?topic=functionality-cgi)

# fastCGI란

fastCGI는 Fast Common gate interface의 약자이다.

[위키백과](https://ko.wikipedia.org/wiki/FastCGI)

---

참고자료

#참고링크/php-fpm_org 

---
