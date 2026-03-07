---
title: '*Dockerfile*'
tags:
  - 'docker'
  - 'uncomplete'
---

**Dockerfile**은 [[이미지]]를 직접 만들기 위한 설정 파일이다.

Dockerfile 스크립트에는 토대가 될 이미지나 실행할 명령어 등을 기재한다.

이 파일을 호스트 컴퓨터의 이미지 재료가 들어있는 폴더(위치는 어디라도 상관없다.)에 넣는다.
재료 폴더에는 그 외 컨테이너에 넣을 파일을 함께 둔다. 실제 컨테이너를 만들 필요는 없다.

## Dockerfile 명령어

### FROM

생성할 이미지의 베이스가 될 이미지를 뜻한다. FROM 명령어는 Dockderfile을 작성할 때 반드시 한 번 이상 입력해야 한다. 이미지 이름의 포맷은 docker run 명령어에서 이미지 이름을 사용했을 때와 같다. 사용하려는 이미지가 도커에 없다면 자동으로 pull 한다.

### MAINTAINER

이미지를 생성한 개발자의 정보를 나타낸다. 일반적으로 Dockefile을 작성한 사람과 연락할 수 있는 메일 등을 입력한다. 단, MAINTAINER는 도커 1.13.0 버전 이후로 사용하지 않는다. 대신 아래와 같은 LABEL로 교체해 표현할 수 있다.

`LABEL maintainer "alicek106 <alicek106@naver.com>"`

### LABEL

^c135e6

이미지에 메타데이터를 추가한다. 메타데이터는 '키:값'의 형태로 저장되며, 여러 개의 메타데이터가 저장될 수 있다. 추가된 메다데이터는 docker inspect 명령어로 이미지의 정보를 구해서 확인할 수 있다.

`docker images --filter "label=...` [[도커 명령어#^2a04f8 | 명령어]]를 통해 특정 라벨만을 가지는 이미지를 출력할 수 있다.

### RUN

이미지를 만들기 위해 컨테이너 내부에서 명령어를 실행한다. 주의할 사항으로, 이미지를 빌드할 때 별도의 입력을 받아야 하는 RUN이 있다면 build 명령어는 이를 오류로 간주하고 빌드를 종료한다.

RUN 명령어에 `["/bin/bash", "echo hello >> test2.html"]`과 같이 입력하면 /bin/bash 셸을 이용해 `echo hello >> test2.html`을 실행한다. Dockerfile의 일부 명령어는 이저철 배열의 형태로 사용할 수 있다. RUN의 경우에는 다음과 같은 형태로 사용된다.

`RUN ["실행 가능한 파일", "명령줄 인자 1", "명령줄 인자 2, ... ]`

이는 JSON 배열의 입력 형식을 따르기 때문에 JSON 형식과 일치해야 한다. 단, JSON 배열 형태로 Dockerfile의 명령어를 사용하면 셸을 실행하지 않는다. 예를 들어, `["echo", "$MY_ENV"]`는 `$MY_ENV` 환경변수를 사용하지 않는다. 이 형태로 셸을 사용하려면  `["sh", "-c", "echo $MY_ENV]`와 같이 사용하는 것이 좋다.

### ADD

파일을 이미지에 추가한다. 추가하는 파일은 Dockerfile이 위치한 디렉터리인 컨텍스트(Context)에서 가져온다.

ADD 명령어는 JSON 배열의 형태로 `["추가할 파일 이름", ... "컨테이너에 추가될 위치"]`와 같이 사용할 수 있다. 추가할 파일명은 여러 개를 지정할 수 있으며 배열의 마지막 원소가 컨테이너에 추가될 위치이다.

#### ADD와 COPY

COPY 또한 로컨 리렉터리에서 읽어들인 컨텍스트로부터 이미지에 파일을 복사하는 역할을 한다.
COPY를 사용하는 형식은 ADD와 같다.

```
COPY test.html /home/
COPY ["test.html", "/home/"]
```

==ADD와 COPY의 차이점==

*COPY는 로컬의 파일만 이미지에 추가할 수 있지만 ADD는 외부 URL 및 tar 파일에서도 파일을 추가할 수 있다는 점에서 다르다.*

즉, COPY의 기능이 ADD에 포함되는 셈이다.
예를 들어, ADD 명령어는 다음과 같이 사용할 수 있다.

`ADD https://raw.github...../test.html /home`

또는 tar 파일을 추가할 수도 있다. 그러나 tar 파일을 그대로 추가하는 것이 아니라 tar 파일을 자동으로 해체해서 추가한다. 다음 명령어는 test.tar 파일을 이미지의 /home 디렉터리에 푼다.

`ADD test.tar /home`

그러나 ADD를 사용하는 것은 그다지 권장하지 않는다. 그 이유는 ADD로 URL이나 tar 파일을 추가할 경우 이미지에 정확히 어떤 파일이 추가될지 알 수 없기 때문이다. 그에 비애 COPY는 로컬 컨텍스트로부터 파일을 직접 추가하기 때문에 빌드 시점에서도 어떤 파일이 추가될지 명확하다.

### WORKDIR

명령어를 실행할 디렉터리를 나타낸다. 배시 셸에서 `cd` 명령어를 입력하는 것과 같은 기능을 한다. 예를 들어, `WORKDIR /var/www/html`이 실행되고 나서 `RUN touch test`를 실행하면 `/var/www/html` 디렉터리에 test 파일이 생성된다.

### EXPOSE

^19bcd3

Dockerfile의 빌드로 생성된 이미지에서 노출할 포트를 설정한다. 그러나 EXPOSE를 설정한 이미지로 컨테이너를 생성했다고 해서 반드시 이 포트가 호스트의 포트와 바인딩되는 것은 아니며, 단지 컨테이너의 80번 포트를 사용할 것임을 나타내는 것 뿐이다. EXPOSE는 컨테이너를 생성하는 run 명령어에서 모든 노출된 컨테이너의 포트를 호스트에 퍼블리시(publish)하는 [[도커 명령어#^ec27f8 | -P 플래그]]와 함께 사용된다.

Dockerfile을 작성하는 개발자로서는 EXPOSE를 이용해 이미지가 실제로 사용될 때 어떤 포트가 사용돼야 하는지 명시할 수 있으며, 이미지를 사용하는 입장에서는 컨테이너의 애플리케이션이 컨테이너 내부에서 어떤 포트를 사용하는지 알 수 있게 된다.

### CMD

CMD는 컨테이너가 시작될 때마다 실행할 명령어(커맨드)를 설정하며, Dockerfile에서 한 번만 사용할 수 있다. Dockerfile에서 CMD를 명시함으로서 이미지에 `apachectl -DFOREGROUND`를 내장하면 컨테이너를 생성할 때 별도의 커맨드를 입력하지 않아도 이미지에 내장된 `apachectl -DFOREGROUND`가 적용되어 컨테이너가 시작될 때 자동으로 아파치 웹서버가 실행된다. 그리고 아파치 웹 서버는 하나의 터미널을 차지하는 포크라운드 모드로 실행되기 때문에 -d 옵션을 사용해 detached 모드로 컨테이너를 생성해야 한다.

즉 CMD는 run 명령어의 이미지 이름 뒤에 입력하는 커맨드와 같은 역할을 하지만 docker run 명령어에서 커맨드 명령줄 인자를 입력하면 Dockerfile에서 사용한 CMD의 명령어는 run의 커맨드로 덮어 쓰인다. 이와 마찬가지로 ubuntu:14.04 이미지에 기본적으로 내장된 커맨드인 `/bin/bash` 또한 Dockerfile의 CMD에 의해 덮어 씌인다.

CMD의 입력은 JSON 배열 형태인 `["실행 가능한 파일",  "명령줄 인자 1", "명령줄 인자 2" ...]` 형태로도 사용할 수 있다.

#### ENTRYPOINT와 CMD

^ffeed1

==ENTRYPOINT와 CMD의 차이점==

entrypoint는 커맨드와 동일하게 컨테이너가 시작될 때 수행할 명령을 지정한다는 점에서 같다. 그러나 entrypoint는 커맨드를 인자로 받아 사용할 수 있는 스크립트의 역할을 할 수 있다는 점에서 다르다.

entrypoint가 설정되지 않았다면 cmd에 설정된 명령어를 그대로 실행하지만 entrypoint가 설정되었다면 cmd는 단지 entrypoint에 대한 인자의 기능을 한다.

```
# # entrypoint: 없음, cmd: /bin/bash
# docker run -it --name no_entrypoint ubuntu:14.04 /bin/bash
-> bash 쉘이 실행
```

```
# # entrypoint: echo, cmd: /bin/bash
# docker run -i -t --entrypoint="echo" --name yes_entrypoint ubuntu:14.04 /bin/bash
-> /bin/bash가 출력. 즉, /bin/bash는 echo의 인자로 넘어감

```

#### JSON 배열 형태와 일반 형식의 차이점

JSON 배열 형태가 아닌 CMD와 ENTRYPOINT를 사용하면 실제로 이미지를 생성할 때 cmd와 entrypoint에 `/bin/sh -c`가 앞에 추가된다.

따라서 CMD 또는 ENTRYPOINT에 설정하려는 명령어를 `/bin/sh`로 사용할 수 없다면 JSON 배열의 형태로 명령어를 설정해야 한다.

```
# 예시

CMD echo tset
# -> /bin/sh -c echo test

ENTRYPOINT /entrypoint.sh
# -> /bin/sh -c /entrypoint.sh
```

CMD와  ENTRYPOINT를 JSON 형태로 명령어를 입력하면 입력된 명령어가 그대로 이미지에서 사용된다.

### ENV

Dockerfile에서 사용될 환경 변수를 지정한다. 설정한 환경변수는 `${ENV_NAME}` 또는 `$ENV_NAME`의 형태로 사용할 수 있다. 이 환경변수는 Dockerfile 뿐 아니라 이미지에도 저장되므로 빌드된 이미지로 컨테이너를 생성하면 이 환경 변수를 사용할 수 있다.

run 명령어에서 -e 옵션을 사용해 같은 이름의 환경변수를 사용하면 기존의 값은 덮어씌어진다.

Dockerfile에서 환경변수의 값을 사용할 때 배시 셸에서 사용하는 것처럼 값이 설정되지 않는 경우와 설정된 경우를 구분해 사용할 수 있다.

쉘 상에서 `${env_name:-value}`는 `env_name`이라는 환경변수의 값이 설정되지 않았으면 이 환경변수의 값을 value로 사용한다. 반대로 `${env_name:+value}`는 `env_name`의 값이 설정돼 있으면 value를 값으로 사용하고, 값이 설정되지 않았다면 빈 문자열을 생성한다.

### VOLUME

빌드된 이미지로 컨테이너를 생성했을 때 호스트와 공유할 컨테이너 내부의 디렉터리를 설정합니다. `VOLUME ["/home/dir", "home/dir2"]`처럼 JSON 배열의 형식으로 여러 개를 사용하거나 `VOLUME /home/dir /home/dir2`로도 사용할 수 있다.

VOLUME이 포함된 Dockerfile로 이미지를 빌드한 뒤 컨테이너를 생성하면 자동으로 볼륨이 생성된다.

### ARG

build 명령어를 실행할 때 추가로 입력을 받아 Dockerfile 내에서 사용될 변수의 값을 설정한다. 다음 Dockefile은 build 명령어에서 `my_arg`와 `my_arg_2`라는 이름의 변수를 추가로 입력받을 것이라고 ARG를 통해 명시한다. ARG의 값은 기본적으로 build 명령어에서 입려받아야 하지만 다음의 `my_arg_2`와 같이 기본값을 지정할수도 있다.

```
FROM ubuntu:14.04
ARG my_arg
ARG my_arg_2=value2
RUN touch ${my_arg}/mytouch
```

[[도커 명령어#^fb817c | build 명령어]]를 실행할 때 `--build-arg` 옵션을 사용해 Dockerfile의 ARG에 값을 입력할 수 있다. 입력하는 형식은 `<키>=<값>`과 같이 쌍을 이뤄야 한다.

`# docker build --build0-arg my_arg=/home -t myarg:0.0 ./`

ARG와 ENV의 값을 사용하는 방법은 `${}`로 같으므로 Dockerfile에서 ARG로 설정한 변수를 ENV에서 같은 이름으로 다시 정의하면 --build-arg 옵션에서 설정하는 값은 ENV에 의해 덮어쓰여진다.

위의 Dockerfile 예제에서는 `$(my_arg)`의 디렉터리에 mytouch라는 파일을 생성했기 때문에 빌드된 이미지로 컨테이너를 생성해 확인하면 mytouch라는 이름의 파일을 확인할 수 있다.

```
# docker run -it --name arg_test myarg:0.0
root@ccdlakjldj:/# ls /home/mytouch
/home/mytouch
```

### USER

USER로 컨테이너 내에서 사용될 사용자 계정의 이름이나 UID를 설정하면 그 아래의 명령어는 해당 사용자 권한으로 실행된다. 일반적으로 RUN으로 사용자의 그룹과 계정을 생성한 뒤 사용한다. 루트 권한이 필요하지 않다면 USER를 사용하는 것을 권장한다.

```
RUN groupadd -r author && useradd -r -g author alicek106
USER alicek106
```

> 기본적으로 컨테이너 내부에서는 root 사용자를 사용하도록 설정된다. 이는 컨테이너가 호스트의 root 권한을 가질 수 있다는 것을 의미하기 때문에 보안 측면에서 매우 바람직하지 않다. 예를 들어 root가 소유한 호스트의 디렉터리를 컨테이너에 공유했을 때, 컨테이너 내부에서는 공유된 root 소유의 디렉터리를 마음대로 조작할 수도 있다.
> 때문에 컨테이너 애플리케이션을 최종적으로 배포할 때는 컨테이너 내부에서 새로운 사용자를 새롭게 생성해 사용하는 것을 권장한다. docker run 명령어 자체에서도 --user 옵션을 지원하지만, 가능하다면 이미지 자체에 root가 아닌 다른 사용자를 설정해놓는 것이 좋다.

### Onbuild
### Stopsignal
### Healthcheck
### Shell



## 빌드 컨텍스트

[[도커 명령어#^fb817c | 이미지 빌드]]를 시작하면 도커는 가장 먼저 빌드 컨텍스트를 읽어들인다. 빌드 컨텍스트는 이미지를 생성하는 데 필요한 각종 파일, 소스 코드, 메타 데이터 등을 담고 있는 디렉터리를 의미하며, Dockerfile이 위치한 디렉터리가 빌드 컨텍스트가 된다.

빌드 컨텍스트는 Dockerfile에서 빌드될 이미지에 파일을 추가할 때 사용된다. Dockerfile에서 이미지에 파일을 추가하는 방법은 앞에서 설명한 ADD 외에도 COPY가 있는데, 이 명령어들은 빌드 컨테스트의 파일을 이미지에 추가한다.

컨테스트에 대한 정보는 이미지를 빌드할 때 출력된 내용 중 맨 위에 위치한다.

컨텍스트는 build 명령어의 맨 마지막에 지정된 위치에 있는 파일을 전부 포함한다. 깃(Git)과 같은 외부 URL에서 Dockerfile을 읽어들인다면 해당 저장소(Repository)에 있는 파일과 서브 모듈을 포함한다.

따라서 Dockerfile이 위치한 곳에는 이미지 빌드에 필요한 파일만 있는 것이 바람직하다. 컨텍스트는 단순 파일 뿐 아니라 하위 디렉토리도 전부 포함하게 되므르 빌드에 불필요한 파일이 포함된다면 빌드 속도가 느려질 뿐더러 호스트의 메모리를 지나치게 점유할 수도 있다.

### .dockerignore

상기한 문제를 방지하기 위해 `.dockerignore`라는 파일을 작성할 수 있다. 이미지 빌드 시 `.dockerignore`에서 명시된 파일은 컨텍스트에서 제외된다.

`.dockerignore` 파일은 **컨텍스트의 최상위 경로, 즉 build 명령어에서 맨 마지막에 오는 경로인 Dockerfile이 위치한 경로**와 같은 곳에 위치해야 한다.

다음은 `.dockerignore` 파일의 예시이다.

```
test2.html
*.html
*/*.html
test.htm?
```

컨텍스트에서 제외할 파일의 경로는 Dockerfile이 존재하는 경로를 기준으로 한다. 예를 들어, build 명령어에서 설정한 경로가 현재 디렉터리이고 `/home/alicek106`이라면 `*.html`은 `/home/alicek106/*.html`에 해당하는 모든 파일을 뜻한다.

`test.htm?`은 `test.htm`을 접두어로 두고 `?` 자리에 임의의 1자리 문자가 들어가는 파일을 제외한다는 뜻이다. `.dockerignore`에 `test.htm?`을 지정하면 `test.htma`, `test.htmb`, `...` 등이 컨텍스트에서 제외된다.

`.dockerignore`의 제외 목록에 해당하지만 특수한 파일만 포함하도록 설정하고 싶다면 `!`를 사용한다.
`!`는 특정 파일을 제외하지 않음을 뜻한다. 다음 예시는 확장자가 `html`인 파일을 모두 제외하지만 `test`로 시작하는 `html` 파일은 컨텍스트에서 제외하지 않는다.

```
*.html
!test*.html
```

### Dockerfile을 이용한 컨테이너 생성과 커밋
### 캐시를 이용한 이미지 빌드
### Dockerfile로 빌드할 때 주의할 점

---

참고자료

#참고도서/그림과_실습으로_배우는_도커_쿠버네티스 
#참고도서/시작하세요_도커_쿠버네티스

---

