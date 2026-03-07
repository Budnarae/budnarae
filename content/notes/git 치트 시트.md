---
tags:
  - git
---

_git cheet sheet_

---

**git에서 잦은 빈도로 사용되는 명령어와 관련된 개념들을 요약하는 문서입니다.**

[여기](https://git-scm.com/book/ko/v2)를 참고하여 만들었습니다.

실용적인 정보를 중심으로 정리하며 git을 사용하는 데 필요없거나(ex. git과 다른 버전 관리 시스템의 차이) 낮은 빈도로 사용되는 기능들은 생략합니다.

# git config - 설정

**git 설정**에 대한 보다 자세한 설명은 [여기](https://git-scm.com/book/ko/v2/%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-Git-%EC%B5%9C%EC%B4%88-%EC%84%A4%EC%A0%95)로

## 사용자 이름과 이메일 주소 설정

이 명령어는 git 설치 후 무조건 1회는 실행해야 한다.

```bash

git config --global user.name "John Doe"
git config --global user.email "johndoe@example.com"

```

## git이 사용할 편집기 설정

```bash

git config --global core.ditor emacs

```

## 설정 확인

```bash

git config --list

```

## 특정 키값만 확인

```text

git config <key>

```

```bash

$ git config user.name
John Doe

```

키값이 세 개의 설정 파일 중 어떤 것에서 설정된 것인지 알기 위해선 --show-origin 옵션과 사용한다.

```bash

$ git config --show-origin rerere.autoUpdate
file:/home/johndoe/.gitconfig	false

```

# git help - 도움말

명령어에 대한 도움말이 필요할 때 도움말을 보는 방법은 두 가지로 동일한 결과를 볼 수 있다.

```bash

$ git help <verb>
$ man git-<verb>

```

예를 들어 아래와 같이 실행하면 `git config` 명령에 대한 도움말을 볼 수 있다.

```bash

$ git help config

```

Git 명령을 사용하기 위해 매우 자세한 도움말 전체를 볼 필요 없이 각 명령에서 사용할 수 있는 옵션들에 대해서 간략히 살펴볼수도 있다. `-h`, `--help` 옵션을 사용하면 다음과 같이 Git 명령에서 사용할 수 있는 옵션들에 대한 간단한 도움말을 출력한다.

```bash

$ git add -h
usage: git add [<options>] [--] <pathspec>...

    -n, --dry-run         dry run
    -v, --verbose         be verbose

    -i, --interactive     interactive picking
    -p, --patch           select hunks interactively
    -e, --edit            edit current diff and apply
    -f, --force           allow adding otherwise ignored files
    -u, --update          update tracked files
    -N, --intent-to-add   record only the fact that the path will be added later
    -A, --all             add changes from all tracked and untracked files
    --ignore-removal      ignore paths removed in the working tree (same as --no-all)
    --refresh             don't add, only refresh the index
    --ignore-errors       just skip files which cannot be added because of errors
    --ignore-missing      check if - even missing - files are ignored in dry run
    --chmod <(+/-)x>      override the executable bit of the listed files

```

# 이미 존재하는 디렉토리를 저장소로 만들기

```bash

git init

```

# 파일의 변경을 staged 상태로 만듬

```bash

git add <file_name>

```

# 파일 상태를 Unstage로 변경

```bash

$ git reset Head <file>

```

# Modified 파일 되돌리기

```bash

$ git checkout -- <file>

```

`git checkout — [file]` 명령은 꽤 위험한 명령이라는 것을 알아야 한다. 원래 파일로 덮어썼기 때문에 수정한 내용은 전부 사라진다. 수정한 내용이 진짜 마음에 들지 않을 때만 사용하자.

# 파일의 변경을 commited 상태로 만듬

```bash

git commit

```

`-m` 옵션을 사용하면 커밋 메세지를 인라인으로 삽입한다.
`-a` 옵션을 사용하면 tracked 상태의 파일을 자동으로 staging area에 넣은 후 커밋한다. 즉, git add 명령어를 생략할 수 있다.
`--amend` 옵션으로 가장 최근의 커밋을 재작성 할 수 있다.

# 기존 저장소 Clone

```bash

git clone <repository_url>

```

다른 디렉토리 이름으로 클론하려면

```bash

git clone <repository_url> <other_name>

```

저장소를 clone 하면 명령은 자동으로 리모트 저장소를 `origin`이라는 이름으로 추가한다.

# 파일 상태 확인

```bash

git status

```

짦막하게 확인하려면 `-s` 또는 `--short` 인자와 사용한다.

```bash

git status -s

```

```bash

git status -short

```

# 파일 무시

[이 문서](https://git-scm.com/book/ko/v2/Git%EC%9D%98-%EA%B8%B0%EC%B4%88-%EC%88%98%EC%A0%95%ED%95%98%EA%B3%A0-%EC%A0%80%EC%9E%A5%EC%86%8C%EC%97%90-%EC%A0%80%EC%9E%A5%ED%95%98%EA%B8%B0)의 **파일 무시하기** 단락 참조

# 어떤 내용이 변경되었는지 확인

unstaged와 staged 상태를 비교

```bash

git diff

```

staged와 commited 상태를 비교

```bash

git diff --staged

```

```bash

git diff --cached

```

# 파일 삭제

`git rm` 명령으로 워킹 디렉토리, 그리고 staging area에서 파일을 삭제할 수 있다.

```bash

git rm

```

이미 파일을 수정했거나 Staging Area에(역주 - Git Index라고도 부른다) 추가했다면 `-f` 옵션을 주어 강제로 삭제해야 한다. 이 점은 실수로 데이터를 삭제하지 못하도록 하는 안전장치다. 커밋 하지 않고 수정한 데이터는 Git으로 복구할 수 없기 때문이다.

또 Staging Area에서만 제거하고 워킹 디렉토리에 있는 파일은 지우지 않고 남겨둘 수 있다. 다시 말해서 하드디스크에 있는 파일은 그대로 두고 Git만 추적하지 않게 한다. 이것은 `.gitignore` 파일에 추가하는 것을 빼먹었거나 대용량 로그 파일이나 컴파일된 파일인 `.a` 파일 같은 것을 실수로 추가했을 때 쓴다. `--cached` 옵션을 사용하여 명령을 실행한다.

```bash

$ git rm --cached README

```

여러 개의 파일이나 디렉토리를 한꺼번에 삭제할 수도 있다. 아래와 같이 `git rm` 명령에 file-glob 패턴을 사용한다.

```bash

$ git rm log/\*.log

```

`*` 앞에 `\` 을 사용한 것을 기억하자. 파일명 확장 기능은 쉘에만 있는 것이 아니라 Git 자체에도 있기 때문에 필요하다. 이 명령은 `log/` 디렉토리에 있는 `.log` 파일을 모두 삭제한다. 아래의 예제처럼 할 수도 있다.

```bash

$ git rm \*~

```

이 명령은 `~` 로 끝나는 파일을 모두 삭제한다.

# 파일 이름 변경

```bash

$ git mv <file_from> <file_to>

```

# 커밋 히스토리 조회

[참고](https://git-scm.com/book/ko/v2/Git%EC%9D%98-%EA%B8%B0%EC%B4%88-%EC%BB%A4%EB%B0%8B-%ED%9E%88%EC%8A%A4%ED%86%A0%EB%A6%AC-%EC%A1%B0%ED%9A%8C%ED%95%98%EA%B8%B0)

`git log` 명령에 `--decorate` 옵션을 사용하면 쉽게 브랜치가 어떤 커밋을 가리키는지 확인할 수 있다.

`--oneline --decorate --graph --all` 옵션과 사용하면 현재 브랜치가 가리키고 있는 히스토리가 무엇이고 어떻게 갈라져 나왔는지 보여준다.

# 리모트 저장소 확인

`git remote` 명령으로 현재 프로젝트에 등록된 리모트 저장소를 확인할 수 있다.

```bash

git remote

```

`-v` 옵션을 주어 단축 이름과 URL을 함께 볼 수 있다.

# 리모트 저장소 추가

```bash

git remote add <단축이름> <url>

```

# 리모트 저장소 조회

리모트 저장소의 구체적인 정보를 확인한다.

```bash

git remote show <remote_repo_name>

```

# 리모트 저장소 이름 변경

```bash

git remote rename <from> <to>

```

# 리모트 저장소 삭제

```bash

git remote remove <remote_repo_name>

```

# fetch

리모트 저장소에서 데이터를 가져오려면 다음과 같이 실행한다.

```bash

git fetch <remote>

```

git fetch 명령은 리모트 저장소의 데이터를 모두 로컬로 가져오지만, 자동으로 Merge 하지 않는다. 따라서 로컬에서 하던 작업을 정리하고 나서 수동으로 Merge해야 한다.

# pull

fetch와 거의 유사한 동작을 한다. 차이점은 데이터를 자동으로 현재 작업하는 코드와 Merge시킨다는 것이다.

```bash

git pull <remote>

```

# push

작업한 내용을 원격 저장소에 업로드한다.

```bash

git push <remote_repo_name> <branch_name>

```

이 명령은 Clone 한 리모트 저장소에 쓰기 권한이 있고, Clone 하고 난 이후 아무도 Upstream 저장소에 Push 하지 않았을 때만 사용할 수 있다. 다시 말해서 Clone 한 사람이 여러 명 있을 때, 다른 사람이 Push 한 후에 Push 하려고 하면 Push 할 수 없다. 먼저 다른 사람이 작업한 것을 가져와서 Merge 한 후에 Push 할 수 있다.

# 태그

[여기](https://git-scm.com/book/ko/v2/Git%EC%9D%98-%EA%B8%B0%EC%B4%88-%ED%83%9C%EA%B7%B8)를 참고

# 새 브랜치 생성

```bash

git branch <branch_name>

```

`-d` 옵션을 사용하면 브랜치를 삭제한다.
아무런 인자, 옵션 없이 실행하면 현재 브랜치의 목록을 보여준다.
`v` 옵션을 실행하면 브랜치마다 마지막 커밋 메세지도 함께 보여준다.

각 브랜치가 지금 어떤 상태인지 확인하기에 좋은 옵션도 있다. 현재 Checkout 한 브랜치를 기준으로 `--merged` 와 `--no-merged` 옵션을 사용하여 Merge 된 브랜치인지 그렇지 않은지 필터링해 볼 수 있다. `git branch --merged` 명령으로 이미 Merge 한 브랜치 목록을 확인한다.

```bash

$ git branch --merged
  iss53
* master

```

`iss53` 브랜치는 앞에서 이미 Merge 했기 때문에 목록에 나타난다. `*` 기호가 붙어 있지 않은 브랜치는 `git branch -d` 명령으로 삭제해도 되는 브랜치다. 이미 다른 브랜치와 Merge 했기 때문에 삭제해도 정보를 잃지 않는다.

반대로 현재 Checkout 한 브랜치에 Merge 하지 않은 브랜치를 살펴보려면 `git branch --no-merged` 명령을 사용한다.

```bash

$ git branch --no-merged
  testing

```

위에는 없었던 다른 브랜치가 보인다. 아직 Merge 하지 않은 커밋을 담고 있기 때문에 `git branch -d` 명령으로 삭제되지 않는다.

```bash

$ git branch -d testing
error: The branch 'testing' is not fully merged.
If you are sure you want to delete it, run 'git branch -D testing'.

```

Merge 하지 않은 브랜치를 강제로 삭제하려면 `-D` 옵션으로 삭제한다.

# 다른 브랜치로 이동

```bash

git checkout <branch_name>

```

브랜치를 만들면서 checkout까지 한번에 하려면 `git checkout` 명령에 `-b`라는 옵션을 추가한다.

```bash

git checkout -b <branch_name>

```

위 명령은 아래 명령을 줄여놓은 것이다.

```bash

git branch <branch_name>
git checkout <branch_name>

```

# Merge

`git merge` 명령으로 합칠 브랜치에서 합쳐질 브랜치를 Merge 하면 된다.

```bash

$ git checkout master
Switched to branch 'master'
$ git merge iss53
Merge made by the 'recursive' strategy.
index.html |    1 +
1 file changed, 1 insertion(+)

```

# 리모트 브랜치 조회

[여기](https://git-scm.com/book/ko/v2/Git-%EB%B8%8C%EB%9E%9C%EC%B9%98-%EB%A6%AC%EB%AA%A8%ED%8A%B8-%EB%B8%8C%EB%9E%9C%EC%B9%98)를 참고
