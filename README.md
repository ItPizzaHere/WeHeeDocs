# WeHee Docs

> WeHee의 자료를 관리하는 문서 레포지토리입니다.

### Quick Links

- [Notion](https://lemonade-log.notion.site/SSAFY-PJT-f8804bbfc7b24b1e91c25a4667a75e61?pvs=4)
- [Jira](https://ssafy.atlassian.net/jira/software/c/projects/S09P12A806/boards/3230)
- [GitLab](https://project.ssafy.com/login?returnPath=%2Fsso)
- [Figma](https://www.figma.com/file/LOZntT4iuXmIPDn6SDdfK3/Main-Board?type=design&node-id=30-10&mode=design)

## Documentation

- [운영](operations/README.md)
  - [Git 컨벤션](operations/git/README.md)
    - [Git 컨벤션 (커밋/브랜치/PR)](operations/git/README.md)
    - [Git 및 Jira 이슈 템플릿](operations/git/templates/README.md)
      - [버그 리포트 템플릿](operations/git/templates/bug-report-template.md)
      - [기능 요청 템플릿](operations/git/templates/feature-request-template.md)
      - [이슈 템플릿](operations/git/templates/issue-template.md)
      - [PR 템플릿](operations/git/templates/pull-request-template.md)
  - [Jira](operations/jira/README.md)
    - [Jira-GitLab 연동하기](operations/jira/jira-gitlab-integration.md)
    - [Jira 컨벤션 및 세미나](operations/jira/jira-conventions-seminar.md)
  - [Docs 작성 규칙](operations/docs/README.md)
- [design](design/README.md)
  - [로고 이미지](design/logo.png)
  - [Figma](design/Figma)
    - [피그마 보는 간단 가이드](design/Figma/README.md)
    - [로고, 컬러팔레트, 무드보드](design/Figma/identity.md)
    - [채팅 프로토타입](design/Figma/chatting-prototype.pdf)
  - [proposal](design/proposal/)
    - [project-proposal](design/proposal/project-proposal.pdf)
    - [chatting-requirements](design/proposal/chatting-requirements.pdf)
    - [mypage-requirements](design/proposal/mypage-requirements.pdf)
    - [board-requirements](design/proposal/board-requirements.pdf)
    - [voiceroom-requirements](design/proposal/voiceroom-requirements.pdf)
    - [references](design/proposal/references.pptx)
    - [vote-requirements](design/proposal/vote-requirements.pdf)
    - [voiceroom-add_some_details](design/proposal/voiceroom-add_some_details.pdf)
    - [planning-presentation](design/proposal/planning-presentation.pdf)
- [architecture](architecture/README.md)
  - [architecture.drawio](architecture/architecture.drawio)
  - [전체 시스템 설계](architecture/README.md)
  - [기술 스택](architecture/tech_stack.md)
  - [일정](architecture/plan.md)
  - [역할 분담](architecture/roles.md)
  - [lounge](architecture/lounge/README.md)
  - [chatting](architecture/chatting/README.md)
    - [채팅 시스템을 구현한다면, 어느 정도 수준의 설계까지 구현 가능할 것인가?](architecture/chatting/plan-for-designing-chatting-architecture.md)
    - [채팅 기능 설계 구체화](architecture/chatting/refining-chatting-feature-design.md)
    - [채팅 예시 프로젝트 실행 - Building Real-Time Apps with Spring, Cassandra, Redis, WebSocket and RabbitMQ](architecture/chatting/sample-project-jorge-acetozi.md)
    - [채팅 아키텍처 설계 - WIP](architecture/chatting/design-chatting-architecture.md)
    - [채팅 기술 스택 조사 - WIP](architecture/chatting/tech-stack.md)
  - [voice-room](architecture/voice-room/README.md)
    - [webRTC 사용 방법](architecture/voice-room/plan-for-voice-room.md)
  - [database](architecture/db/README.md)
    - [사용자 데이터베이스 테이블 설계](architecture/db/user-db-table.md)
    - [MBTI 라운지 데이터베이스 테이블 설계](architecture/db/mbti-lounge-db-table.md)
    - [채팅 데이터베이스 테이블 설계](architecture/database/chatting-db-table.md)
    - [사용자 및 MBTI 라운지 데이터베이스 테이블 생성&기본 데이터 삽입 SQL](architecture/db/user_lounge_init.sql)
  - [sequence-diagram](architecture/sequence-diagram/README.md)
    - [채팅 시퀀스 다이어그램 - WIP](architecture/sequence-diagram/chatting-sequence-diagram.md)
- [development](development/README.md)
  - [How to Run](development/how-to-run.md)
  - [백엔드 개발자의 API 만들기](development/how-to-make-api-in-spring-boot.md)
  - [Spring Boot 환경 설정 - WIP](development/spring-boot-env-setting.md)
  - [도커 설정 - WIP](development/docker-setting.md)
  - [Spring WebSocket - WIP](development/spring-websocket.md)
  - [소셜 로그인을 이용한 인증 기능 구현하기 - WIP](development/authentication-development.md)
  - [채팅 기능 구현하기 - WIP](development/chatting-development.md)
  - [Annotations in Spring Boot - WIP](development/annotations-in-spring-boot.md)
  - [배포 - WIP](development/deployment.md)
  
- [infrastructure](infrastructure/README.md)
- [presentation](presentation/README.md)
- [consulting](consulting/README.md)
  - [week2](consulting/week2/README.md)
    - [week2 result](consulting/week2/week2-consulting-result.md)
    - [week3 plan](consulting/week2/week3-consulting-plan.md)
  - [week3](consulting/week3/README.md)
    - [week3 result](consulting/week3/week3-consulting-result.md)
- [decisions](decisions/README.md)
- [review](review/README.md)
  - [study](review/study/README.md)
    - [[책] Cracking the PM Interview: How to Land a Product Manager Job in Technology(Cracking the Interview & Career) - WIP](review/study/cracking-the-pm-interview.md)
    - [[책] 도메인 주도 설계 핵심](review/study/domain-driven-development-core.md)
    - [[책] 가상 면접 사례로 배우는 대규모 시스템 설계 기초](review/study/system-design-interview.md)
    - [[책] Building Real-Time Apps with Spring, Cassandra, Redis, WebSocket and RabbitMQ - WIP](review/study/building-real-time-apps.md)
    - [Hexagonal Architecture](review/study/hexagonal-architecture.md)
    - [OAuth를 이용한 소셜 로그인 구현](review/study/social-login-using-oauth.md)
    - [Docker](review/study/docker.md)
    - [RDBMS와 NoSQL DB의 차이](review/study/differences-between-rdmbs-and-nosql-db.md)
    - [Spring Security](review/study/spring-security.md)
    - [CSRF](review/study/csrf.md)
    - [Cassandra - WIP](review/study/cassandra.md)
    - [Redis](review/study/redis.md)
    - [Stateless와 Stateful 서비스 - WIP](review/study/stateless-and-stateful-services.md)
    - [분산 트랜잭션 - WIP](review/study/distributed-transaction.md)
  - [roadmap](review/roadmap/README.md)
    - [프론트엔드 로드맵 만들기](review/roadmap/frontend-roadmap.md)
    - [기획 로드맵 만들기 - WIP](review/roadmap/product-management-roadmap.md)
  - [story](review/story/README.md)
    - [우리의 기획이 어설플 수밖에 없는 이유](review/story/reasons-of-our-product-design-is-clumsy.md)
    - [목적이 다른 여러 사람이 각자, 그리고 공동의 목표를 이룰 방법은?](review/story/ways-of-achieving-personal-and-public-goals.md)
    - [공부하고 조사한 내용은 많은데 왜 개발은 느릴까? - WIP](review/sotry/why-development-gets-slower.md)

------

## How to Use?

WeHee 프로젝트를 진행하면서 생성된 모든 자료를 업데이트합니다.

1. 업로드 전 해당 스프린트 주차에 맞게 브랜치를 생성합니다. (참고: [브랜치 네이밍 규칙](#브랜치-네이밍-규칙))
2. md/pdf/pptx 등 자료 생성
3. 적절한 경로에 자료 업데이트 후 커밋
4. [메인 README](#wehee-docs) 목록에 자료 경로 업데이트 후 커밋
   폴더나 파일명은 [폴더 및 파일명 규칙](#폴더-및-파일명-규칙)을 따라주시되, README에서 제목은 자유롭게 설정해주셔도 좋습니다. 
5. Jira Issue 댓글에 자료 경로 업데이트
6. main 브랜치에 PR 요청
7. 팀원들과 공유

<br>

## 명명 규칙

### 브랜치 네이밍 규칙

​	`<week><주차(숫자)>-<식별 가능한 이름>`

### 폴더 및 파일명 규칙

폴더와 파일은 모두 **영어(소문자)/숫자로 작성**해 주세요. 띄어쓰기가 있다면 모두 '-'로 대체해주시기 바랍니다.

> 예시: How to make GitHub raedme → `how-to-make-github-readme`

<br>

## 폴더 생성 및 관리

만약 자료를 업로드할 적절한 폴더가 없다면 자유롭게 생성하시면 됩니다

<br>

## 자료는 없지만 회의에서 결정사항이 생긴 경우

[결정 사항](decisions/README.md) 폴더 밑에 `<이슈 번호> <제목>.md` 파일을 생성해주시고 해당 결정사항을 업데이트 해주시면 됩니다. 커밋 후 Jira Issue 댓글에 파일 링크를 업데이트해주세요.
