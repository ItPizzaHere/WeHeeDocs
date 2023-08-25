# WeHee Docs

> WeHee의 자료를 관리하는 문서 레포지토리입니다.

### EXTERNAL LINKS

- [Notion](https://lemonade-log.notion.site/SSAFY-PJT-f8804bbfc7b24b1e91c25a4667a75e61?pvs=4)
- [Jira](https://ssafy.atlassian.net/jira/software/c/projects/S09P12A806/boards/3230)
- [GitLab](https://project.ssafy.com/login?returnPath=%2Fsso)
- [Figma](https://www.figma.com/file/LOZntT4iuXmIPDn6SDdfK3/Main-Board?type=design&node-id=30-10&mode=design)

# Documentation

### QUICK LINKS

표 안의 내용을 클릭하면 해당 목차로 이동합니다. 

| [WeHee 개발](#wehee-개발)    | [프로젝트 운영](#프로젝트-운영)  | [학습](#학습)          |
| ---------------------------- | -------------------------------- | ---------------------- |
| [1. 기획](#1-기획)           | [1. 컨벤션](#1-컨벤션)           | [1. 세미나](#1-세미나) |
| [2. 디자인](#2-디자인)       | [2. 운영](#2-운영)               | [2. 공부](#2-공부)     |
| [3. 설계](#3-설계)           | [3. 발표](#3-운영)               | [3. 회고](#3-회고)     |
| [4. 기능 구현](#4-기능-구현) | [4. 포팅 매뉴얼](#4-포팅-매뉴얼) |                        |

# WeHee 개발

## 1. [기획](proposal/README.md)

  - [프로젝트 기획서](proposal/project-proposal.pdf)
  - [요구사항](proposal/requirements/README.md)
    - [마이페이지 요구사항](proposal/requirements/mypage-requirements.md)
    - [우리집 요구사항](proposal/requirements/board-requirements.md)
    - [채팅 요구사항](proposal/requirements/chatting-requirements.md)
    - [보이스룸 요구사항](proposal/requirements/voice-room-requirements.md)
  - [자료조사](proposal/references.pdf)

## 2. [디자인](design/README.md)

- [로고 및 컬러 팔레트](design/logo-and-pallete.md)
- [와이어프레임](design/wireframe.md)
- [프로토타입](design/prototype/README.md)
  - [메인 및 회원 프로토타입](design/prototype/main-prototype.md)
  - [우리집 프로토타입](design/prototype/board-prototype.md)
  - [채팅 프로토타입](design/prototype/chatting-prototype.md)
  - [보이스룸 프로토타입](design/prototype/voice-room-prototype.md)
- [피그마 보는 간단 가이드](design/figma-guide.md)

## 3. [설계](architecture/README.md)

- [시스템 설계](architecture/system-architecture.md)
  - [architecture.drawio](architecture/architecture.drawio)
- [데이터베이스 설계](architecture/database.md)

## 4. [기능 구현](development/README.md)

- [소셜 로그인을 이용한 인증 기능 구현하기 - WIP](development/authentication-development.md)
- [채팅](development/chatting/README.md)
  - [채팅 기획 구체화](development/refining-chatting-feature-design.md)
  - [채팅 기술 스택 선정](development/design-chatting-architecture.md)
  - [채팅 요구사항 파악](development/chatting-requirements.md)
  - [시퀀스 다이어그램 작성](development/chatting-sequence-diagram.md)

# 프로젝트 운영

## 1. [컨벤션](conventions/README.md)

- [Git 컨벤션](conventions/git/README.md)
- [Jira 컨벤션](conventions/jira/README.md)
  - [Jira-GitLab 연동하기](conventions/jira/jira-gitlab-integration.md)
  - [Jira 컨벤션 및 세미나](conventions/jira/jira-conventions-seminar.md)
- [Git 및 Jira 이슈 템플릿](conventions/git/templates/README.md)
  - [버그 리포트 템플릿](conventions/git/templates/bug-report-template.md)
  - [기능 요청 템플릿](conventions/git/templates/feature-request-template.md)
  - [이슈 템플릿](conventions/git/templates/issue-template.md)
  - [PR 템플릿](conventions/git/templates/pull-request-template.md)
- [Docs 작성 규칙](operations/docs/README.md)

## 2. [운영](operations/README.md)

- [기술 스택](operations/tech_stack.md)
- [일정](operations/plan.md)
- [역할 분담](operations/roles.md)

## 3. [발표](presentation/README.md)

- [기획 발표](presentation/planning-presentation.pdf)
- [최종 발표](presentation/final-presentation.pdf)
- [UCC](presentation/wehee.mp4)

## 4. [포팅 매뉴얼](mannual/README.md)

- [로컬 실행 매뉴얼](mannual/how-to-run.md)
- [배포 매뉴얼](mannual/deployment.md)
- 기타
   - [백엔드 빌드하기](mannual/build-backend.md)
   - [프론트엔드 빌드하기](mannual/build-frontend.md)
   - [프로젝트 버전 정보](mannual/versions.md)
- [데이터](mannual/data/README.md)
   - [wehee_create.sql](mannual/data/wehee_create.sql)
   - [wehee_dump.sql](mannual/data/wehee_dump.sql)

# 학습

## 1. [세미나](seminar/README.md)

- [Jira 컨벤션 및 세미나](conventions/jira/jira-conventions-seminar.md)
- [How to Run](seminar/how-to-run.md)
- [백엔드 개발자의 API 만들기](seminar/how-to-make-api-in-spring-boot.md)
- [컨설팅](seminar/consulting/README.md)
  - [2주차 컨설팅 보고](seminar/consulting/week2-consulting.md)
  - [3주차 컨설팅 보고](seminar/consulting/week3-consulting.md)

## 2. [공부](research/README.md)

### 설계

- [설계](research/architecture/README.md)
  - [Hexagonal Architecture](research/architecture/hexagonal-architecture.md)
- [데이터베이스](research/database/README.md)
  - [RDBMS와 NoSQL DB의 차이](research/database/differences-between-rdmbs-and-nosql-db.md)
  - [Cassandra - WIP](research/database/cassandra.md)
  - [Redis](research/database/redis.md)
- [인프라](research/infra/README.md)
  - [Docker](research/infra/docker.md)
  - [Stateless와 Stateful 서비스 - WIP](research/infra/stateless-and-stateful-services.md)
  - [분산 트랜잭션 - WIP](research/infra/distributed-transaction.md)
  - [IntelliJ Big Data Tools로 EC2 접속하기](research/infra/intellij-ec2.md)

### 개발

- [Spring Boot](research/spring-boot/README.md)
  - [Spring Boot 환경 설정 - WIP](research/spring-boot/spring-boot-env-setting.md)
  - [Spring WebSocket - WIP](research/spring-boot/spring-websocket.md)
  - [Annotations in Spring Boot - WIP](research/spring-boot/annotations-in-spring-boot.md)
  - [Spring Security](research/spring-boot/spring-security.md)
- [인증 및 인가](research/auth/README.md)
  - [OAuth를 이용한 소셜 로그인 구현](research/auth/social-login-using-oauth.md)
  - [CSRF](research/auth/csrf.md)
- [채팅](research/chatting/README.md)
  - [채팅 시스템을 구현한다면, 어느 정도 수준의 설계까지 구현 가능할 것인가?](research/chatting/plan-for-designing-chatting-architecture.md)
  - [채팅 예시 프로젝트 실행 - Building Real-Time Apps with Spring, Cassandra, Redis, WebSocket and RabbitMQ](research/chatting/sample-project-jorge-acetozi.md)

### 기타

- [책 리뷰](research/books/README.md)
  - [Cracking the PM Interview: How to Land a Product Manager Job in Technology(Cracking the Interview & Career) - WIP](research/books/cracking-the-pm-interview.md)
  - [도메인 주도 설계 핵심](research/books/domain-driven-development-core.md)
  - [가상 면접 사례로 배우는 대규모 시스템 설계 기초](research/books/system-design-interview.md)
  - [Building Real-Time Apps with Spring, Cassandra, Redis, WebSocket and RabbitMQ - WIP](research/books/building-real-time-apps.md)

## 3. [회고](review/README.md)

- [로드맵 만들기](review/roadmap/README.md)
  - [프론트엔드 로드맵 만들기](review/roadmap/frontend-roadmap.md)
  - [기획 로드맵 만들기 - WIP](review/roadmap/product-management-roadmap.md)
- [이야기](review/story/README.md)
  - [우리의 기획이 어설플 수밖에 없는 이유](review/story/reasons-of-our-product-design-is-clumsy.md)
  - [목적이 다른 여러 사람이 각자, 그리고 공동의 목표를 이룰 방법은?](review/story/ways-of-achieving-personal-and-public-goals.md)
  - [공부하고 조사한 내용은 많은데 왜 개발은 느릴까? - WIP](review/story/why-development-gets-slower.md)
  - [최종 발표일 중계](review/story/final-presentation.md)
  - [프로젝트, 끝났지만 끝나지 않았는데요](review/story/it-never-gets-over.md)
  - [WeHee를 하며 배운 내용과 앞으로 배워야 할 내용](review/story/what-ive-learn-from-the-project.md)
