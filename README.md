# WeHee Docs

> WeHee의 자료를 관리하는 문서 레포지토리입니다.

### Quick Links

- [Notion](https://lemonade-log.notion.site/SSAFY-PJT-f8804bbfc7b24b1e91c25a4667a75e61?pvs=4)
- [Jira](https://ssafy.atlassian.net/jira/software/c/projects/S09P12A806/boards/3230)
- [GitLab](https://project.ssafy.com/login?returnPath=%2Fsso)

## Documentation

- [operations](operations/README.md)
  - [conventions](operations/conventions/README.md)
  - [docs](operations/docs/README.md)
  - [jira](operations/jira/README.md)
    - [Jira-GitLab Integration](operations/jira/jira-gitlab-integration.md)
    - [Jira Conventions Seminar](operations/jira/jira-conventions-seminar.md)
- [design](design/README.md)
- [architecture](architecture/README.md)
  - [chatting](architecture/chatting/README.md)
    - [채팅 시스템을 구현한다면, 어느 정도 수준의 설계까지 구현 가능할 것인가?](architecture/chatting/plan-for-designing-chatting-architecture.md)
    - [채팅 기능 설계 구체화](architecture/chatting/refining-chatting-feature-design.md)
    - [채팅 아키텍처 설계 - 쓰는 중](architecture/chatting/design-chatting-architecture.md)
- [development](development/README.md)
  - [frontend](development/frontend/README.md)
  - [board](development/board/README.md)
  - [live](development/live/README.md)
  - [chatting](development/chatting/README.md)
  - [user](development/user/README.md)
- [infrastructure](infrastructure/README.md)
- [presentation](presentation/README.md)
- [consulting](consulting/README.md)
  - [week2](week2/README.md)
    - [week2 result](week2/week2-consulting-result.md)
    - [week3 plan](week2/week3-consulting-plan.md)
- [decisions](decisions/README.md)
- [review](review/README.md)
  - [study](review/study/README.md)
    - [[책] Cracking the PM Interview: How to Land a Product Manager Job in Technology(Cracking the Interview & Career) - 쓰는 중](review/study/cracking-the-pm-interview.md)
    - [[책] 도메인 주도 설계 핵심](review/study/domain-driven-development-core.md)
    - [[책] 가상 면접 사례로 배우는 대규모 시스템 설계 기초](review/study/system-design-interview.md)
    - [Hexagonal Architecture](review/study/hexagonal-architecture.md)
  - [roadmap](review/roadmap/README.md)
    - [프론트엔드 로드맵 만들기](review/roadmap/frontend-roadmap.md)
    - [기획 로드맵 만들기 - 쓰는 중](review/roadmap/product-management-roadmap.md)
  - [우리의 기획이 어설플 수밖에 없는 이유](review/reasons-of-our-product-design-is-clumsy.md)
  - [목적이 다른 여러 사람이 각자, 그리고 공동의 목표를 이룰 방법은?](review/ways-of-achieving-personal-and-public-goals.md)
  


------

## How to Use?

WeHee 프로젝트를 진행하면서 생성된 모든 자료를 업데이트합니다.

1. md/pdf/pptx 등 자료 생성
2. 적절한 경로에 자료 업데이트
3. [메인 README](#wehee-docs) 목록에 자료 경로 업데이트

   폴더나 파일명은 [폴더 및 파일명 규칙](#폴더-및-파일명-규칙)을 따라주시되, README에서 제목은 자유롭게 설정해주셔도 좋습니다. 
4. Jira Issue 댓글에 자료 경로 업데이트
5. 팀원들과 공유

### 폴더 및 파일명 규칙

폴더와 파일은 모두 **영어(소문자)/숫자로 작성**해 주세요. 띄어쓰기가 있다면 모두 '-'로 대체해주시기 바랍니다.

> 예시: How to make GitHub raedme → `how-to-make-github-readme`

### 폴더 생성 및 관리

만약 자료를 업로드할 적절한 폴더가 없다면 자유롭게 생성하시면 됩니다

### 자료는 없지만 회의에서 결정사항이 생긴 경우

[결정사항](decisions/README.md) 폴더 밑에 `<이슈 번호> <제목>.md` 파일을 생성해주시고 해당 결정사항을 업데이트 해주시면 됩니다. 커밋 후 Jira Issue 댓글에 파일 링크를 업데이트해주세요.
