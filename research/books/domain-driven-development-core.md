# 도메인 주도 설계 핵심



DDD에 대한 책을 어제 다 읽었다. 이제는 스프링 프로젝트에도 DDD를 적용하고 싶은데, 어떻게 적용할지가 고민이다. 찾아본 레포들은 전부 상업화를 목표로 개발된 레포들이라 개인 프로젝트 수준에 적용하기에는 어려워 보이고(그것을 적용할 만큼 내 수준이 높아 보이지도 않고), 아직 내가 모르는 기술들도 많아서 조금 더 참고할만한 레포들을 찾는 중이다.

### 짧은 결론

DDD를 제대로 구현하기 위해서는 팀에 속한 개발자들이 모두 '잘하는' 개발자여야 하고, 일단 내가 '잘하는'에 속하지 않기 때문에 이번 프로젝트에는 적용하기 힘들겠다는 생각이 들었다. BUT... 언젠가 쓸 날이 오겠지 

### 짧은 회고

DDD 개념 책을 읽은 것에 대해 짧은 회고를 해보자면, 일단 이벤트 스토밍 단계에서 이해하지 못했던 단계들을 이해할 수 있어서 좋았다고 말할 수 있겠다. 왜 이벤트 스토밍마다 단계가 있었는지, 포스트잇의 색과 붙이는 규칙들이 어쩌다가 생겼는지 이해할 수 있게 됐다. 애그리게잇에 대한 이해도 생겨서 다음번 이벤트 스토밍 단계에 적용하면 좋겠다는 생각도 했다. 사실상 AntAlbum은 이벤트 스토밍을 하기 위한 이벤트 스토밍처럼 느껴졌달까? 우리가 100% 이벤트 스토밍을 활용하지 못했다는 생각이 들었다 (그만큼 다음번에 다시 이벤트 스토밍을 하면 훨씬 더 효율성이 높아지겠다는 것을 암시하는 것이니 여전히 이벤트 스토밍을 했다는 것 자체는 긍정적으로 작용한다).

DDD의 목적을 제대로 달성한다는 가정 하에 이벤트 스토밍을 진행한다면 먼저 각 도메인별로 핵심 데이터베이스는 물론, 클래스 구조, 패키지 구조, 그리고 개발 일정까지도 어느 정도 틀이 잡히지 않을까 하는 기대가 생긴다.

### 그래도 구현은 어렵다

문제는 이런식으로 이벤트 스토밍을 하려면 어떻게 구현을 할 것인가에 대한 기본적인 감각이 있어야 하는데 아직까지는 어떻게 구현을 하면 좋을지에 대한 아이디어가 없는 것. 각 바운디드 컨텍스트에서 도메인 이벤트가 발생하면 그 컨텍스트를 구독하는 다른 컨텍스트에 메시지를 보내거나 그에 따른 반응 메서드를 비동기식으로 작동시킬 수 있어야 하는데, 그것을 내가 잘 이해하고 활용할 수 있을지 모르겠다. Spring 내부에서 이벤트를 비동기식으로 발생을 시키는 것이 관례인지, 그것이 관례가 맞다면 어떻게 핸들링을 해야할지 조차도 모르겠고, 만약 카프카를 사용해 메시징을 보내는 방식으로 구현을 해야 한다면 우리 수준에서(갓 스프링을 배운 싸피 1학기 수료생을 기준으로) 하는 것이 적절한 것인가에 대한 질문도 있다.

또 한가지 책을 읽으면서 궁금한 점이 있었다면, 만약 도메인별로 개발자가 배정이 되고 각 도메인마다 통신을 하는 방식으로, 혹은 메시징을 보내는 방식으로 기능이 연결된다고 한다면, 이걸 유동적으로 개발 환경을 맞추기 위해 로컬에서 계속 개발을 하는 것이 좋을지, 아니면 클라우드 위에 띄워놓고 개발을 하는 것이 좋을지 모르겠다는 것이다(어쩌다보니 문장이 너무 길어져버렸…). 그리고 만약 기능별로도 RESTful하게 개발을 한다면, 각 기능마다 서버를 독립적으로 띄워놓는 것을 의미하는 것인지, 그렇다면 각 서버마다 사용하는 port를 다르게 해야 하는 것인지에 대한 궁금증도 생겼달까?

+영속성에 대한 개념을 확실히해둘 필요가 있지 않나 싶다. DDD에 대한 개념을 읽으면서도 영속성에 대한 설명이 나와있는데, JPA를 사용할 때도 그렇고 이 개념이 무엇인지 확실하게 짚고 넘어가지 않아서 무언가 찝찝함이 계속 마음 속에 남이있다.

### 일단 찾아본 DDD spring projects

- https://github.com/ddd-by-examples/library
- https://github.com/BottegaIT/ddd-leaven-v2
- https://github.com/mploed/ddd-with-spring
- https://github.com/JoeCao/qbike
- https://github.com/christophknabe/spring-ddd-bank

### GPT 추천 repos

- GPT 답변

  Certainly! Here are a few Spring projects that have implemented Domain-Driven Design (DDD) principles and can serve as examples for your web application project:

  1. **Spring PetClinic**: This is a popular sample application provided by the Spring team itself. It demonstrates various Spring technologies and can serve as a good starting point for understanding how DDD concepts can be applied in a real-world web application. You can find the project on GitHub: **[spring-projects/spring-petclinic](https://github.com/spring-projects/spring-petclinic)**
  2. **Sculptor**: Sculptor is a code generator that generates the skeleton of an application based on DDD principles. It generates the domain model, repositories, services, and other artifacts based on a textual description. While it's not a Spring-specific project, it can be integrated with Spring. You can find the project on GitHub: **[sculptor/sculptor](https://github.com/sculptor/sculptor)**
  3. **Eventuate Tram**: Eventuate Tram is a framework for developing transactional microservices using Domain-Driven Design and event sourcing. It provides a way to implement distributed transactions across microservices and supports Spring Boot integration. You can find the project on GitHub: **[eventuate-tram/eventuate-tram-core](https://github.com/eventuate-tram/eventuate-tram-core)**
  4. **Axon Framework**: Axon is a CQRS and event sourcing framework that promotes DDD principles. It provides infrastructure components and patterns for building scalable and maintainable applications. While not Spring-specific, it integrates well with Spring Boot. You can find the project on GitHub: **[AxonFramework/AxonFramework](https://github.com/AxonFramework/AxonFramework)**

  These projects can give you insights into how DDD concepts can be implemented in a web application using Spring. Remember that DDD is a design approach, and its implementation may vary depending on the specific domain and requirements of your project.

- https://github.com/spring-projects/spring-petclinic

- https://github.com/sculptor/sculptor

- https://github.com/eventuate-tram/eventuate-tram-core

- https://github.com/AxonFramework/AxonFramework

- https://github.com/eugenp/tutorials/tree/master/ddd

### 해볼만한 repos

- topics: https://github.com/topics/spring-kafka
- https://github.com/piomin/sample-spring-kafka-microservices