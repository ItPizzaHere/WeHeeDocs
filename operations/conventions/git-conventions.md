# Git Conventions

마지막 업데이트 날짜: 2023-08-04 <br>
작성자: 김예진

[Jira-GitLab Integration](../jira/jira-gitlab-integration.md)의 [Jira project - GitLab branch, commit 연동 결과 확인](../jira/jira-gitlab-integration.md#jira-project---gitlab-branch-commit-연동-결과-확인) 섹션 참고

> **목차**
>
> 1. [Branch Conventions](#1-branch-conventions)
>    1. [Branch Naming Convention](#branch-naming-convention)
>    2. [Jira를 활용한 브랜치 생성](#jira를-활용한-브랜치-생성)
> 2. [Commit Conventions](#2-commit-conventions)
>    1. [Commit Example](#commit-example)
>    2. [Commit Template](#commit-template)
>    3. [Commit Type](#commit-type)
> 3. [PR Conventions](#pr-conventions)
>    1. [PR Naming Convention](#pr-naming-convention)
>    2. [Jira를 활용한 PR](#jira를-활용한-pr)

# 1. Branch Conventions
## Branch Naming Convention

| 이름        | 규칙                         | 설명                                                   | 분기점  | 병합점          |
| ----------- | ---------------------------- | ------------------------------------------------------ | ------- | --------------- |
| Master      | `main`                       | 배포 가능한 최종 상태의 브랜치                         | -       | Develop         |
| Develop     | `develop`                    | 기능 개발을 위한 분기 및 병합 지점으로 사용하는 브랜치 | Master  | Release         |
| Release     | `release/v<release-version>` | 배포를 위한 마무리 작업 브랜치                         | Develop | Master          |
| Hotfix      | `hotfix/v<hotfix-version>`   | 배포 버전에서 발생한 버그 긴급 수정 작업 브랜치        | Master  | Master, Develop |
| Feature     | `feature/<feature-name>`     | 기능 개발 브랜치                                       | Develop | Develop         |
| Refactoring | `refactor/<feature-name>`    | 리팩토링 브랜치                                        | Develop | Develop         |

## Jira를 활용한 브랜치 생성

# 2. Commit Conventions

## Commit Example

```bash
git commit -m "S09P12A806-105/feat: 로그인 기능 구현"
```

## Commit Template

`<Jira project code>-<issue#>/<commit type>: <commit message>`


## Commit Type

| 이름     | 규칙                                     | 설명                                     |
| -------- | ---------------------------------------- | ---------------------------------------- |
| feat     | `feat: <contents>`                       | 새로운 기능에 대한 커밋                  |
| fix      | `fix: <contents>`      | build 빌드 관련 파일 수정에 대한 커밋    |
| docs     | `docs: <contents>`     | 문서 수정에 대한 커밋                    |
| style    | `style: <contents>`    | 코드 스타일 혹은 포맷 등에 관한 커밋     |
| refactor | `refactor: <contents>` | 코드 리팩토링에 대한 커밋                |
| test     | `test: <contents>`     | 테스트 코드 수정에 대한 커밋             |
| chore    | `chore: <contents>`    | 그 외 자잘한 수정에 대한 커밋(기타 변경) |
| setting  | `ci: <contents>`       | 환경 설정 관련 커밋                      |

# 3. PR Conventions
## PR Naming Convention
## Jira를 활용한 PR



