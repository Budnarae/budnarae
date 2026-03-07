---
tags:
  - git
---

_git 히스토리 내역 삭제_

---

# BFG Repo-Cleaner 사용 가이드

Git 히스토리에서 큰 파일이나 폴더를 완전히 제거하는 방법

## 1. 사전 준비

### 1.1 Java 설치

BFG는 Java로 작성되어 있어 Java Runtime이 필요합니다.

#### Windows

**방법 1: winget 사용 (권장)**

```powershell
# 관리자 권한 PowerShell
winget install Microsoft.OpenJDK.17
```

**방법 2: 수동 다운로드**

- https://adoptium.net/temurin/releases/
- Windows x64 `.msi` 다운로드 및 설치
- 설치 시 "Add to PATH" 옵션 체크

#### 설치 확인

```powershell
# 새 PowerShell 창에서
java -version
```

### 1.2 Java PATH 설정 (자동 설정 안될 경우)

#### Java 설치 경로 찾기

```powershell
Get-ChildItem "C:\Program Files" -Recurse -Filter "java.exe" -ErrorAction SilentlyContinue | Select-Object FullName
```

#### PATH에 추가 (관리자 권한 PowerShell)

```powershell
# 예시 경로: C:\Program Files\Microsoft\jdk-17.0.17.10-hotspot\bin
$javaPath = "C:\Program Files\Microsoft\jdk-17.0.17.10-hotspot\bin"

# 현재 PATH 가져오기
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

# Java 경로 추가
$newPath = $currentPath + ";" + $javaPath
[Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
```

**반드시 새 PowerShell 창을 열어 확인!**

### 1.3 BFG Repo-Cleaner 다운로드

- https://rtyley.github.io/bfg-repo-cleaner/
- `bfg-1.15.0.jar` 다운로드 (최신 버전)
- 다운로드 폴더에 저장됨

## 2. 사용 준비

### 2.1 백업 (중요!)

```powershell
# 원본 저장소 백업
git clone --mirror <원본저장소URL> backup.git
```

### 2.2 프로젝트 루트로 이동

```powershell
cd "C:\Users\YourName\Desktop\YourProject"
```

### 2.3 BFG 파일 프로젝트로 복사 (선택사항)

```powershell
Copy-Item "$env:USERPROFILE\Downloads\bfg-1.15.0.jar" .
```

## 3. BFG 사용법

### 3.1 기본 문법

```powershell
java -jar <BFG경로> <옵션> <대상>
```

### 3.2 경로 지정 방법

#### BFG JAR 파일 경로

```powershell
# 절대 경로 (따옴표 필수)
java -jar "C:\Users\GameTeckLab\Downloads\bfg-1.15.0.jar" <옵션>

# 환경 변수 사용
java -jar "$env:USERPROFILE\Downloads\bfg-1.15.0.jar" <옵션>

# 현재 디렉토리에 복사한 경우
java -jar bfg-1.15.0.jar <옵션>
```

#### 삭제 대상 지정

```powershell
# ❌ 잘못된 방법 (전체 경로 사용)
java -jar bfg-1.15.0.jar --delete-folders Project\Data\Fbx\Juggernaut

# ✅ 올바른 방법 (폴더 이름만)
java -jar bfg-1.15.0.jar --delete-folders Juggernaut
```

### 3.3 주요 옵션

#### 특정 폴더 삭제

```powershell
java -jar bfg-1.15.0.jar --delete-folders 폴더명
```

#### 특정 파일 삭제

```powershell
java -jar bfg-1.15.0.jar --delete-files 파일명.확장자
```

#### 특정 크기 이상 파일 모두 삭제

```powershell
# 50MB 이상 파일 삭제
java -jar bfg-1.15.0.jar --strip-blobs-bigger-than 50M

# 100MB 이상 파일 삭제
java -jar bfg-1.15.0.jar --strip-blobs-bigger-than 100M
```

#### 여러 폴더 동시 삭제

```powershell
java -jar bfg-1.15.0.jar --delete-folders "{folder1,folder2,folder3}"
```

## 4. 전체 작업 흐름

### 4.1 큰 파일/폴더 찾기 (선택사항)

```powershell
# 히스토리에서 가장 큰 파일 10개 찾기
git rev-list --objects --all | `
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | `
  Select-String "^blob" | `
  ForEach-Object { $_ -replace "^blob ", "" } | `
  Sort-Object { [int]($_ -split ")[1] } -Descending | `
  Select-Object -First 10
```

### 4.2 BFG 실행

```powershell
# 예시: Juggernaut 폴더 삭제
java -jar bfg-1.15.0.jar --delete-folders Juggernaut
```

**출력 예시:**

```
Using repo : C:\...\YourProject\.git
Found 1030 objects to protect
Cleaning commits: 100% (1402/1402)
In total, 6 object ids were changed
BFG run is complete!
```

### 4.3 Git 정리 (필수!)

```powershell
# 참조 로그 제거
git reflog expire --expire=now --all

# 가비지 컬렉션 (공격적 정리)
git gc --prune=now --aggressive
```

### 4.4 원격 저장소에 반영

```powershell
# 강제 푸시 (주의!)
git push --force
```

## 5. 주의사항

### 5.1 협업 시 필수 확인사항

⚠️ **`git push --force`는 히스토리를 재작성합니다!**

- 팀원들에게 사전 공지
- 모든 팀원이 기존 로컬 저장소 삭제
- 새로 `git clone` 받아야 함
- 진행 중인 작업은 별도 백업

### 5.2 Protected Commits

BFG는 현재 HEAD를 보호합니다:

- 현재 커밋에 존재하는 파일은 삭제 안됨
- 히스토리에만 남은 파일을 대상으로 함

### 5.3 경로 주의사항

```powershell
# ❌ 상대 경로 (~)는 PowerShell에서 작동 안함
java -jar ~/Downloads/bfg.jar

# ✅ 절대 경로 또는 환경 변수 사용
java -jar "$env:USERPROFILE\Downloads\bfg.jar"
```

## 6. 확인

### 저장소 크기 확인

```powershell
git count-objects -vH
```

### GitHub/GitLab에서 확인

- 저장소 설정 페이지에서 크기 확인
- 변경사항이 즉시 반영 안될 수 있음 (캐시)

## 7. 문제 해결

### "No refs to update - no dirty commits found?"

**원인:** 삭제하려는 파일/폴더가 히스토리에 없음

**해결:**

- 폴더 이름 확인
- 경로가 아닌 이름만 입력했는지 확인

### "Unable to access jarfile"

**원인:** JAR 파일 경로를 찾지 못함

**해결:**

```powershell
# 절대 경로 사용
java -jar "C:\Users\...\Downloads\bfg-1.15.0.jar"

# 또는 현재 디렉토리로 복사
Copy-Item "$env:USERPROFILE\Downloads\bfg-1.15.0.jar" .
java -jar bfg-1.15.0.jar
```

### Java 명령 인식 안됨

**해결:**

1. Java 설치 확인: `java -version`
2. PATH 설정 확인
3. **새 PowerShell 창** 열기
4. 시스템 재부팅

## 8. 전체 예제

```powershell
# 1. 프로젝트로 이동
cd "C:\Users\GameTeckLab\Desktop\MyProject"

# 2. BFG로 Juggernaut 폴더 삭제
java -jar "$env:USERPROFILE\Downloads\bfg-1.15.0.jar" --delete-folders Juggernaut

# 3. Git 정리
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# 4. 크기 확인
git count-objects -vH

# 5. 강제 푸시
git push --force
```

---

## 참고 자료

- BFG 공식 사이트: https://rtyley.github.io/bfg-repo-cleaner/
- Java Adoptium: https://adoptium.net/
- Git 공식 문서: https://git-scm.com/docs
