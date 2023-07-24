# OAuth를 이용한 소셜 로그인 구현

> **목차**
>
> 1. [OAuth2 이해하고 적용하기](#1-oauth2-이해하고-적용하기)
>    1. [발급받은 키 정보](#1--1-발급받은-키-정보)
>    2. [왜 예제들에서는 다들 인증에 3000번 포트를 사용하는가?](#1--2-왜-예제들에서는-다들-인증에-3000번-포트를-사용하는가-)
>    3. [OAuth에 CORS 설정이 들어가는 이유?](#1-3. AOuth에 CORS 설정이 들어가는 이유?)
> 2. [여기에서 더 심화한다면?](#2. 여기에서 더 심화한다면?)
>    1. [Redis를 이용한 유저 정보 관리](#2-1.Redis를 이용한 유저 정보 관리)
>    1. [보안에 집중](#2-2. 보안에 집중)

- 실습 레포
  - 아래의 두 레포를 가져와 간단하게 OAuth를 실습함
  - https://github.com/sushistack/oauth-login-be
  - https://github.com/sushistack/oauth-login-fe

# 1. OAuth2 이해하고 적용하기

- 참고
  - [Spring Boot OAuth2.0 적용기](https://geonoo.tistory.com/163)
  - [[Spring Boot\] OAuth2 소셜 로그인 가이드 (구글, 페이스북, 네이버, 카카오)](https://deeplify.dev/back-end/spring/oauth2-social-login#스프링부트-소셜-로그인)
  - https://github.com/geonoo/Oauth2
  - https://github.com/oAuth-Buttons/logo-providers
  - sushistack
    - https://github.com/sushistack/oauth-login-fe
    - https://github.com/sushistack/oauth-login-be

## 1-1. 발급받은 키 정보

- Google 적용
  - Client ID: [605283717298-voq314sdhq2r21kmactrsjq5ocpkjqje.apps.googleusercontent.com](http://605283717298-voq314sdhq2r21kmactrsjq5ocpkjqje.apps.googleusercontent.com)
  - Client Secret: ...
- Facebook 적용
  - 앱ID: 1311934296366552
  - 앱 시크릿 코드: ...
- 네이버 적용
  - Client ID: n6HeGahiy0ain66ELkEo
  - Client Secret: ...
- 카카오 적용
  - REST API 키: 3b9caee37027b4675d69d8202b1187a5
  - Secret Client: ...

## 1-2. 왜 예제들에서는 다들 인증에 3000번 포트를 사용하는가?

- 답변 - ChatGPT

  In OAuth2 using Spring Boot, the choice of using a different port for user authorization (often port 3000) and a separate port for the service server is not a requirement of OAuth2 itself, but rather a common practice in web development.

  The reason behind using different ports is typically related to security and separation of concerns. Here's an explanation of why this practice is commonly followed:

  1. User Authorization: The port 3000 (or any other port) is often used for the user authorization flow. This is the process where users grant permission to the client application to access their protected resources (e.g., user profile, email, etc.) on their behalf. Separating the authorization process onto a different port helps in isolating the security concerns related to user authentication and consent. It allows developers to focus on securing the authorization flow specifically and enables fine-grained control over the endpoints and security configurations related to user authentication.
  2. Service Server: The service server, which provides the actual functionality or data accessed by the client application after authorization, typically runs on a different port (e.g., port 8080). This separation allows developers to isolate the service server logic from the user authorization flow. The service server can focus solely on serving the requested resources, implementing business logic, and handling client requests without being burdened by the intricacies of the user authentication and authorization process.

  By separating these concerns onto different ports, developers can maintain a clear separation of roles and responsibilities, improve the security of the overall system, and achieve better modularity in their application architecture.

  It's important to note that the specific port numbers used, such as 3000 for authorization and 8080 for the service server, are not mandated by any standard. They are merely conventions often followed by developers, but you can choose any available ports that suit your needs.

## 1-3. AOuth에 CORS 설정이 들어가는 이유?

- CORS에 대한 간단한 정리 - [우테코 테코톡](https://www.youtube.com/watch?v=-2TgkKYmJt4)
- [참고](https://taes-k.github.io/2019/12/05/spring-cors/)

내가 이해한 바에 따르면, OAuth를 통해 로그인을 하지 않은 경우(로그인 전) 토큰 헤더에 OPTIONS method에 대한 검증해제 로직이 들어가지 않기 때문에 해당 설정을 하지 않으면 CORS 에러가 나게 된다. 따라서 OAuth2를 사용할 때는 CORS를 설정해야 한다.

# 2. 여기에서 더 심화한다면?

어제 명익님께서 1학기 때 OAuth를 어떤식으로 깊이 있게 공부하셨는지 간략한 설명을 들었다. 무엇이든 들으면 금방 까먹어버리는 금붕어 뇌를 가진 나는... 말씀해주신 것들에 대해 간략하게만 기억하고 있을 뿐, 내가 기억한 것이 정확한 것인지는 차차 검증을 해나가야 할 것 같다.

## 2-1.Redis를 이용한 유저 정보 관리

Redis를 이용해 유저의 정보를 관리하면 효율성이 더 높아진다고 말씀하셨는데, 이유가 무엇인지는 이제부터 공부해야 한다. 추측하건대 Redis는 아마 key-value DB이기 때문에 RDB보다 처리 속도가 더 빨라서 DB로부터 유저의 정보를 가져오는 데에 걸리는 시간이 빨라져서 효율성이 높아지지 않을까 하는 생각을...

## 2-2. 보안에 집중

대부분의 사람들이 OAuth를 사용하면 라이브러리 가져다 쓰기 수준으로 마무리를 한다지만, 여기에 추가적인 보안을 더 걸어두고자 한다면 끝도 없이 파고들 수 있겠다는 생각이 든다. 이것도 차차 공부가 필요한 부분.