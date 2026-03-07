---
title: 'envsubst'
tags:
  - 'linux/cmd'
---

`envsubst`는 환경 변수 값을 텍스트에 치환(substitute)하는 데 사용하는 유용한 도구입니다. 일반적으로 쉘 스크립트에서 템플릿 파일을 처리하거나 환경 변수 기반 설정 파일을 생성할 때 사용됩니다. `envsubst`는 GNU `gettext` 패키지에 포함되어 있으며, 특히 `bash` 환경에서 자주 사용됩니다.

### 기본 사용법

bash

코드 복사

`envsubst < input_template_file > output_file`

위 명령은 `input_template_file` 내의 `${VARIABLE}` 형식의 환경 변수를 실제 값으로 치환한 결과를 `output_file`에 저장합니다.

---

### 주요 옵션과 사용법

1. **전체 환경 변수 치환** 환경 변수를 정의하고 이를 치환:
    
    bash
    
    코드 복사
    
    `export VAR1="Hello" export VAR2="World" echo '${VAR1} ${VAR2}' | envsubst`
    
    **출력:**
    
    코드 복사
    
    `Hello World`
    
2. **특정 변수만 치환** `envsubst`에 `$VARIABLE` 목록을 지정하면 해당 변수들만 치환됩니다.
    
    bash
    
    코드 복사
    
    `export VAR1="Hello" export VAR2="World" echo '${VAR1} ${VAR2}' | envsubst '${VAR1}'`
    
    **출력:**
    
    bash
    
    코드 복사
    
    `Hello ${VAR2}`
    
3. **파일을 템플릿으로 사용** 템플릿 파일을 작성하고 환경 변수를 치환:
    
    **템플릿 파일 (example.txt):**
    
    bash
    
    코드 복사
    
    `Hello, ${NAME}! Welcome to ${PLACE}.`
    
    **스크립트:**
    
    bash
    
    코드 복사
    
    `export NAME="Alice" export PLACE="Wonderland" envsubst < example.txt > output.txt cat output.txt`
    
    **출력 (output.txt):**
    
    css
    
    코드 복사
    
    `Hello, Alice! Welcome to Wonderland.`
    
4. **명령과 조합** 다른 명령과 조합하여 동적으로 내용을 생성:
    
    bash
    
    코드 복사
    
    `export USER="John" echo "User: ${USER}, Date: $(date)" | envsubst`
    
    **출력:**
    
    yaml
    
    코드 복사
    
    `User: John, Date: Thu Nov 21 12:00:00 2024`
    

---

### 참고 사항

- **변수 형식:** `envsubst`는 `${VARIABLE}` 또는 `$VARIABLE` 형식의 변수를 인식합니다. 단, `${}` 형태를 사용하는 것이 더 안전합니다.
    
- **미정의 변수 처리:** 환경 변수가 정의되지 않은 경우, 변수가 그대로 출력됩니다.
    
- **특정 변수가 없을 경우 디폴트 값 사용:** 치환 전에 변수를 기본값으로 설정하면 활용도가 높아집니다.
    
    bash
    
    코드 복사
    
    `export NAME=${NAME:-DefaultName} echo "Hello, ${NAME}" | envsubst`
    

### 설치

Linux에서 `envsubst`는 `gettext` 패키지에 포함되어 있으므로 다음 명령으로 설치할 수 있습니다:

- **Ubuntu/Debian:**
    
    bash
    
    코드 복사
    
    `sudo apt-get install gettext`
    
- **CentOS/RHEL:**
    
    bash
    
    코드 복사
    
    `sudo yum install gettext`
    

`envsubst`는 환경 변수 기반 설정을 쉽게 관리하도록 돕는 매우 간단하면서도 강력한 도구입니다. ???

==주의 : 이 명령어는 이미지 빌드 타임에는 환경 변수를 제대로 읽지 못한다. 따라서 반드시 Dockerfile의 RUN이 아니라 ENTRYPOINT로 넘겨서 실행시켜야 한다.==
