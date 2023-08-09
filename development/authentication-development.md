# 소셜 로그인을 이용한 인증 기능 구현하기

마지막 업데이트 날짜: 2023-08-08 <br>
작성자: 김예진

> **목차**
>
> 1. [요구사항 파악](#1-요구사항-파악)
>    1. [로그인](#로그인)
>    2. [회원가입](#회원가입)
>    3. [유저 요구사항](#유저-요구사항)
>    4. [유저 테이블](#유저-테이블)
>    5. [리프레시 토큰 테이블](#리프레시-토큰-테이블)
> 2. [예시 프로젝트 실행 및 분석](#2-예시-프로젝트-실행-및-분석)
>    1. [예시 프로젝트 정보](#예시-프로젝트-정보)
>    2. [실행 결과](#실행-결과)
>       1. [실행 화면 및 DB 저장 내용](#실행-화면-및-db-저장-내용)
>    3. [DB 분석](#db-분석)
>       1. [User 테이블 구조](#user-테이블-구조)
>       2. [WeHee와 비교 - User](#wehee와-비교---user)
>       3. [USER REFRESH TOKEN 테이블 구조](#user-refresh-token-테이블-구조)
>       4. [WeHee와 비교 - Refresh Token](#wehee와0비교---refresh-token)
>    4. [gradle 분석](#gradle-분석)
>       1. [인증을 위한 의존성 추가](#인증을-위한-의존성-추가)
>       2. [build.gradle - configuration exclude](#buildbradle---configuration-exclude)
>    5. [config 클래스 분석](#config-클래스-분석)
>       1. [SecurityConfig.java](#securityconfigjava)
> 3. [Entity 및 Enum class 구현](#3-entity-및-enum-class구현)
>    1. [User class](#user-class)
>    2. [RefreshToken class](#refreshtoken-class)
>    3. [MBTI enum class](#mbti-enum-class)
>    4. [Provider enum class](#provider-enum-class)
> 4. [기본 Service 및 Repository class 구현](#4-기본-service-및-repository-classs-구현)
>    1. [UserRepository](#userrepository)
>    2. [UserService](#userservice)
> 5. [API 및 비즈니스 로직 개발](#5-api-및-비즈니스-로직-개발)
>    1. [소셜 로그인 시퀀스 다이어그램](#소셜-로그인-시퀀스-다이어그램)
>       1. [시퀀스 다이어그램 설명](#시퀀스-다이어그램-설명)
>    2. [`소셜 로그인하기` 버튼을 누를 때](#소셜-로그인하기-버튼을-누를-때)
>    3. [예시 프로젝트 로그 분석](#예시-프로젝트-로그-분석)
> 6. [획득한 유저 정보 이용해 인증된 유저 객체 만들기](#6-획득한-유저-정보-이용해-인증된-유저-객체-만들기)
>    1. [`CustomOAuth2UserService 클래스 구현을 위한 밑작업](#customoauth2userservice-클래스-구현을-위한-밑작업)
>    2. [`UserPrincipal` 클래스 구현](#userprincipal-클래스-구현)
>       1. [Principal class 사용하는 이유?](#principal-class-사용하는-이유)
>    3. [소셜 로그인을 위한 환경 설정](#소셜-로그인을-위한-환경-설정)
>       1. [application.yml 작성](#applicationyml-작성)
>    4. [`oauth/info` 패키지 하단의 OAuth2UserInfoFactory 관련 클래스 작성](#oauthinfo-패키지-하단의-oauth2userinfofactory-관련-클래스-작성)
>       1. [`OAuth2UserInfoFactory` class](#oauth2userinfofactory-class)
>       2. [`OAuth2UserInfo` abstract class](#oauth2userinfo-abstract-class)
>       3. [`OAuth2UserInfo`를 상속받는 나머지 IdP별 classes](#oauth2userinfo를-상속하는-나머지-idp별-classes)
>    5. [프로젝트 실행 - 유저 객체](#프로젝트-실행---유저-객체)
> 7. [Application Properties 설정](#7-application-properties-설정)
>    1. [application.yml](#applicationyml)
>    2. [config/properties 하위의 custom property classes](#configproperties-하위의-custom-property-classes)
> 8. [Spring Security 설정](#8-spring-security-설정)
>    1. [`SecurityConfig` class filterChain() 설정](#securityconfig-class-filterchain-설정)
>       1. [CORS 설정](#cors-설정)
>       2. [`RestAuthenticationEntryPoint` class implements `AuthenticationEntryPoint`](#restauthenticationentrypoint-class-implements-authenticationentrypoint)
>       3. [oauth2Login()설정](#oauth2login설정)
>       4. [oauth2Login().authorizationEndpoint().baseUri("/oauth2/authorization") 설정](#oauth2loginauthorizationendpointbaseurioauth2authorization-설정)
>       5. [redirectionEndpoint().baseUri("/oauth2/code/") 설정](#redirectionendpointbaseurioauth2code-설정)
>    2. [프로젝트 실행 - Spring Security](#프로젝트-실행---spring-security)
> 9. [JWT 엑세스 토큰과 리프레시 토큰 생성](#9-jwt-엑세스-토큰과-리프레시-토큰-생성)
>

이 글은 소셜 로그인을 이용한 인증 기능 구현 개발기로, 시간의 순서에 따라 글이 작성되었습니다.

# 1. 요구사항 파악

## 로그인

![](images/dev06.PNG)

## 회원가입

![](images/dev07.PNG)

## 유저 요구사항

> 1. 정보 등록
>    1. 사용자는 소셜 회원가입을 할 수 있다.
>    2. 소셜 로그인 시, 가입하는 플랫폼이 다른 경우 다른 계정으로 간주한다.
>    3. 사용자는 첫 로그인 이후, 마이페이지에 본인의 생년, 성별, MBTI, 닉네임을 입력해야 한다.
>       1. 닉네임은 영어, 한글, 숫자만 가능하다.
>    4. 초기 닉네임은 랜덤으로 배정된다.
>    5. 사용자의 최종 닉네임은 ‘**닉네임 [MBTI]**’형식으로 정해진다.
>    6. 생년, 성별, MBTI를 입력하는 모달이 뜨고, 입력 없이 창을 닫는 경우 로그인 할 때마다 입력하는 모달이 뜬다.
>    7. 사용자는 자신의 프로필에 사진을 업로드할 수 있다.
> 2. 마이페이지 수정
>    1. 사용자들은 마이페이지 정보를 수정할 수 있다.
>    2. MBTI 유형 정보는 한 번 수정한 경우, 수정 시점을 기준으로 5주가 지나야 재수정이 가능하다.
>    3. 닉네임은 중복확인 이후에 변경할 수 있다.
>    4. 성별, 생년은 1번만 수정이 가능하다.
> 3. 회원 탈퇴
>    1. 사용자는 서비스에서 탈퇴할 수 있다.
>    2. 탈퇴한 사용자가 작성한 게시글 및 댓글은 삭제되지 않는다.
>    3. 사용자 닉네임은 ‘탈퇴한 사용자’로 바뀐다.

## 유저 테이블

![](images/dev08.PNG)

이 테이블에 createed 컬럼을 추가하고 싶다.

## 리프레시 토큰 테이블

![](images/dev18.png)


# 2. 예시 프로젝트 실행 및 분석

## 예시 프로젝트 정보

- [OAuth를 이용한 소셜 로그인 구현](../review/study/social-login-using-oauth.md)
- sushistack
  - https://github.com/sushistack/oauth-login-fe
  - https://github.com/sushistack/oauth-login-be
- https://github.com/ikjo93/share-travel

## 실행 결과

### 실행 화면 및 DB 저장 내용

![](images/dev09.PNG)

## DB 분석

### User 테이블 구조

![](images/dev10.PNG)

### WeHee와 비교 - User

![](images/dev11.jpg)

### USER REFRESH TOKEN 테이블 구조
![](images/dev19.png)

### WeHee와 비교 - Refresh Token

![](images/dev18.png)

## gradle 분석

### 인증을 위한 의존성 추가

![](images/dev12.PNG)

### build.gradle - configuration exclude

```groovy
configurations {
    all*.exclude group: 'org.springframework.boot', module: 'spring-boot-starter-logging'
    all*.exclude group: 'org.springframework.boot', module: 'logback-classic'
}
```

Spring Boot에서 의존성을 추가하면서 의도치 않게 다운 받은 jar 설정 파일을 제거하는 기능을 수행한다.

## config 클래스 분석

![](images/dev13.PNG)

위의 의존성 추가까지 적용하고 난 후 실행을 하니 위와 같은 실행 결과가 나왔다. 검색을 해보니 Spring Security를 설정했기 때문이라고([참고](https://ict-nroo.tistory.com/118)). 이를 해결하기 위해 `SecurityConfig.java`에서 Spring Security 관련 설정을 하기로 했다.

### SecurityConfig.java

![](images/dev14.PNG)

Adapter를 구현하기 위해 `WebSecurityConfiguraterAdapter`를 상속 받으려고 했는데 클래스가 deprecated된 것을 알게 되었다([참고](https://devlog-wjdrbs96.tistory.com/434)). 순간 의존성 추가할 때 설정한 버전을 예시 코드대로 낮출까 고민했는데 언젠간 이 귀찮은 작업을 또 하게 되는 순간이 오겠지... 하는 생각을 하며 그냥 진행하기로 했다. 일단 임시적으로 [Spring blog](https://spring.io/blog/2022/02/21/spring-security-without-the-websecurityconfigureradapter)를 참고해 내용을 간단하게 채웠다. <br>

일단 여기까지 하고 얼추 프로젝트 실행이 되는 것을 확인한 후 config는 잠시 뒤로 미루고 비즈니스 로직부터 짜기로 헀다.

# 3. Entity 및 Enum class구현

사용자 인증을 위한 entity는 User밖에 없다. 위에 있는 User 테이블 구조를 그대로 사용하되, MBTI만 enum class로 관리한다.

## User class

```java
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Entity
public class User {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 소셜 로그인에서 얻을 정보
    private String provider_id;
    private String provider;
    private int birth;
    private char gender;
    private String profile;

    // 사용자 입력 정보
    private String nickname;
    private MBTI mbti;

    // 자동 생성 정보(시스템 내부)
    @Temporal(TemporalType.DATE)
    private LocalDate last_mbti_modified;
    private boolean birth_changed;
    private boolean gender_changed;
    private boolean withdrawal;

    @Temporal(TemporalType.DATE)
    private LocalDate created;

}
```

- `access = AccessLevel.PROTECTED` 설정
  - 외부에서 클래스 생성 시 기본 생성자 호출을 막기 위함

- `Setter`를 생성하지 않아 외부로부터 변수가 쉽게 바뀌는 것을 막음
- `@GeneratedValue`에서 IDENTITY 옵션을 사용해 sequence table이 생성되는 것을 막음([참고](https://gmlwjd9405.github.io/2019/08/12/primary-key-mapping.html))
- `@Temporal` annotation으로 DB type에 맞게 DB가 저장되도록 함

## RefreshToken class

생략

## MBTI enum class

생략

## Provider enum class

생략

# 4. 기본 Service 및 Repository  class 구현

## UserRepository

생략

## UserService

생략

# 5. API 및 비즈니스 로직 개발

## 소셜 로그인 시퀀스 다이어그램

![](images/dev16.jpeg)

### 시퀀스 다이어그램 설명

![](images/dev17.png)

[출처](https://deeplify.dev/back-end/spring/oauth2-social-login#%EC%8B%9C%ED%80%80%EC%8A%A4-%EC%84%A4%EB%AA%85)

## `소셜 로그인하기` 버튼을 누를 때

프론트엔드에서는 `네이버로 로그인하기`버튼을 누르면 백엔드로 어떤 API를 호출할까?

![](images/dev15.PNG)

1. 위의 그림에 따르면 GET 메소드가 다음과 같이 요청된다
    `/oauth2/authorization/naver?redirect_uri=http://localhost:3000/oauth/redirect`
2. 웹서버로 해당 요청이 전달되고, provider-id에 따라 지정된 OAuth 2.0 provider가 해당 요청을 처리하게 요청을 처리하게 라우팅한다.
   - 백엔드에서 따로 코드를 짤 필요는 없음, `application.yml` 설정 이용
3. (provider) 로그인 페이지로 리다이렉트를 하면, 클라이언트는 provider 서비스에 로그인한다.
4. 클라이언트가 로그인에 성공하면 IdP 서버로부터 백엔드로 Authorization 코드가 응답된다.
5. 백엔드에서 인가 코드를 확인해 IdP 서버로 엑세스 토큰을 요청한다.
6. 계속...

## 예시 프로젝트 로그 분석

> 9-1
> =================================loadUser()==============CustomOAuth2UserService
> =================================->getOAuth2UserInfo()=======OAuth2UserInfoFactory
> =================================->UserPrincipal.create()=======UserPrincipal
> id:2815283392
> connected_at:2023-06-01T07:01:17Z
> properties:{nickname=정보, profile_image=정보, thumbnail_image=정보} kakao_account:{profile_nickname_needs_agreement=false, profile_image_needs_agreement=false, profile={nickname=정보, thumbnail_image_url=정보, profile_image_url=정보, is_default_image=false}, has_email=true, email_needs_agreement=false, is_email_valid=true, is_email_verified=true, email=정보}
> 
> 9-2, 9-3
>=================================onAuthenticationSuccess()===OAuth2AuthenticationSuccessHandler
> =================================->getOAuth2UserInfo()=======OAuth2UserInfoFactory
> =================================->createAuthToken2()=======AuthTokenProvider -- access token
> =================================->createAuthToken1()=======AuthTokenProvider -- refresh token
> 
> 토큰 필터
>=================================doFilterInternal()=========TokenAuthenticationFilter
> =================================->convertAuthToken()=======AuthTokenProvider
> =================================->getAuthentication()=======AuthTokenProvider
> 
> 11
>=================================getUser()==============UserController

로그와 코드 내용을 대조해본 결과, 클라이언트가 소셜 로그인에 성공했을 때 `CustomOAuth2UserService` class에서 loadUser()가 호출되고 유저의 정보를 DB에 저장하는 과정이 가장 먼저 일어났다. 그 다음 소셜 로그인 성공/실패 핸들러가 JWT 토큰과 리프레시 토큰을 만드는 일에 관여한다. 이후 클라이언트에게 토큰을 전달하는 부분부터는 살짝 막힌 상태인데 오늘(2023-08-04) 이 부분은 앞에 부분을 개발하다보면 해결할 수 있을 것 같아 보인다. <br>

쿠키와 토큰 필터 부분(아직은 미지의 영역)을 거치면 `UserController`의 getUser()가 호출된다.

# 6. 획득한 유저 정보 이용해 인증된 유저 객체 만들기
## `CustomOAuth2UserService` 클래스 구현을 위한 밑작업

클라이언트 측에서 소셜 로그인에 성공하면 `CustomOAuth2UserService` class에서 loadUser()가 호출된다. 이 메소드가 호출하는 메소드까지 정리하면 처리하는 내용은 다음과 같다.

1. 유저의 이메일 주소가 이미 다른 IdP로부터 제공받은 이메일인지 확인한다.
2. 새로 등록되는 이메일 주소인 경우 유저 정보를 `UserPrincipal` 객체로 만들어 리턴한다. 

## `UserPrincipal` 클래스 구현

`CustomOAuth2UserService` 클래스에서 `loadUser()`를 호출하면 OAuth2User 타입의 객체를 반환하는데, 이 객체는 UserPrincipal 클래스로 만들 수 있다. UserPrincipal 객체는 현재 인증된 사용자를 의미한다.

### Principal class 사용하는 이유?

by ChatGPT

> In Spring Boot OAuth 2.0, the `Principal` class is used to represent the currently authenticated user. It provides a convenient way to access user-related information after a successful authentication. The `Principal` object is automatically populated by the Spring Security framework once the user has been authenticated, and it allows you to access details about the authenticated user, such as their username, authorities, and other attributes.
>
> Here are some reasons why using the `Principal` class is beneficial in Spring Boot OAuth 2.0 development:
>
> 1. Easy access to user information: The `Principal` class abstracts away the details of how the user's information is obtained and authenticated. It provides a standardized way to access user-related data without dealing with low-level authentication mechanisms.
> 2. Simplified authorization: Once the user is authenticated, you can use the `Principal` object to check the user's roles, authorities, or custom attributes to make authorization decisions within your application.
> 3. Avoiding the need for manual retrieval: Without the `Principal` class, you would need to manually retrieve user information from the security context or session, which could be error-prone and cumbersome. Spring Security automatically handles this for you.
> 4. Integration with Spring Security: Spring Boot integrates seamlessly with Spring Security, and the `Principal` class is an essential part of the security framework. It helps maintain a consistent and standard way of accessing user information across different parts of your application.

## 소셜 로그인을 위한 환경 설정

### application.yml 작성

새로 추가한 부분은 다음과 같다. 예시 프로젝트보다 더 많은 정보가 필요해 해당 부분을 추가하고, 민감한 client id와 client secret은 모두 환경 변수로 바꿨다.

```yml
spring:
    security:
      oauth2.client:
        registration:
          google:
            clientId: ${GOOGLE_CLIENT_ID}
            clientSecret: ${GOOGLE_CLIENT_SECRET}
            scope:
              - email
              - profile
              - gender.read
              - birthday.read
          naver:
            clientId: ${NAVER_CLIENT_ID}
            clientSecret: ${NAVER_CLIENT_SECRET}
            clientAuthenticationMethod: post
            authorizationGrantType: authorization_code
            redirectUri: "{baseUrl}/{action}/oauth2/code/{registrationId}"
            clientName: Naver
          kakao:
            clientId: ${KAKAO_CLIENT_ID}
            clientSecret: ${KAKAO_CLIENT_SECRET}
            clientAuthenticationMethod: post
            authorizationGrantType: authorization_code
            redirectUri: "{baseUrl}/{action}/oauth2/code/{registrationId}"
            scope:
              - profile_nickname
              - profile_image
              - account_email
              - gender
              - birthyear
            clientName: Kakao
        provider:
          naver:
            authorizationUri: https://nid.naver.com/oauth2.0/authorize
            tokenUri: https://nid.naver.com/oauth2.0/token
            userInfoUri: https://openapi.naver.com/v1/nid/me
            userNameAttribute: response
          kakao:
            authorizationUri: https://kauth.kakao.com/oauth/authorize
            tokenUri: https://kauth.kakao.com/oauth/token
            userInfoUri: https://kapi.kakao.com/v2/user/me
            userNameAttribute: id
```

## `oauth/info` 패키지 하단의 OAuth2UserInfoFactory 관련 클래스 작성

소셜 로그인에 성공한 유저의 정보를 받아 오려면 각 IdP별로 정보를 받아오는 클래스를 만들어야 한다. 이 역할을 `OAuth2UserInfo` 클래스의 getOAuth2UserInfo()가 처리해준다. getOAuth2UserInfo()는 인증 서버로부터 attributes를 넘겨 받으면 IdP별로 정보를 파싱하는 `OAuth2UserInfo` 상속 객체를 반환한다. 

### `OAuth2UserInfoFactory` class

```java
public static OAuth2UserInfo getOAuth2UserInfo(ProviderType providerType, Map<String, Object> attributes) {
        switch (providerType) {
            case GOOGLE: return new GoogleOAuth2UserInfo(attributes);
            case FACEBOOK: return new FacebookOAuth2UserInfo(attributes);
            case NAVER: return new NaverOAuth2UserInfo(attributes);
            case KAKAO: return new KakaoOAuth2UserInfo(attributes);
            default: throw new IllegalArgumentException("Invalid Provider Type.");
        }
    }
```

### `OAuth2UserInfo` abstract class

```java
public abstract class OAuth2UserInfo {
    protected Map<String, Object> attributes;

    public OAuth2UserInfo(Map<String, Object> attributes) {
        this.attributes = attributes;
    }

    public Map<String, Object> getAttributes() {
        return attributes;
    }

    public abstract String getId();

    public abstract String getName();

    public abstract String getEmail();

    public abstract String getImageUrl();
}
```

### `OAuth2UserInfo`를 상속하는 나머지 IdP별 classes

1. `GoogleOAuth2UserInfo`
2. `KakaoOAuth2UserInfo`
3. `NaverOAuth2UserInfo`

## 프로젝트 실행 - 유저 객체

![](images/dev20.png)

여기까지 구현한 내용으로 프로젝트를 실행해보면 다음과 같이 동작한다. 로그인 버튼을 누르면 소셜 로그인을 수행하기 위한 모달이 나오고, 여기에서 아무 버튼이나 클릭하면 `http://localhost:8080`에 로그인하라는 화면을 마주하게 된다. 이때 취소를 누르면 `http://localhost:8080/oauth2/authorization/google?redirect_uri=http://localhost:3000/oauth/redirect` 링크에 대한 페이지가 작동하지 않는다는 창으로 리다이렉트 된다. <br>

저 `사용자 이름`, `비밀번호` 입력창이 나오는 이유는 Spring Security 때문이라는데, 이참에 Spring Security와 그놈의 CORS를 한 번 처리해보기로 했다.

# 7. Application Properties 설정

Spring Security 설정을 하기에 앞서 애플리케이션에서 사용하게 될 프로퍼티들을 먼저 설정하기로 한다. 수정할 부분은 Application class와 applicaiton.yml, custom property classes이다. 커스텀할 프로퍼티들의 내용들은 다음과 같다.

## application.yml

```yaml
# AppProperties
app:
  auth:
    tokenSecret: 926D96C90030DD58429D2751AC1BDBBC
    tokenExpiry: 1800000
    refreshTokenExpiry: 604800000
  oauth2:
    authorizedRedirectUris:
      - http://localhost:3000/oauth/redirect

# CorsProperties
cors:
  allowed-origins: 'http://localhost:3000'
  allowed-methods: GET,POST,PUT,DELETE,OPTIONS
  allowed-headers: '*'
  max-age: 3600
```

## config/properties 하위의 custom property classes

`config/properties` 패키지 내부에 설정할 properties class를 각각 만든다.

1. `AppProperties` class
2. `CorsProperties` class

## WeHeeApplication class

`@EnableConfigurationProperties` annotation을 이용해 애플리케이션 클래스에 커스텀 프로퍼티 빈을 등록한다.

```java
@SpringBootApplication
@EnableConfigurationProperties({
	CorsProperties.class,
	AppProperties.class
})
public class WeheeApplication {

	public static void main(String[] args) {
		SpringApplication.run(WeheeApplication.class, args);
	}

}
```

# 8. Spring Security 설정

- 공부 내용 기록
  - [Spring Security](../review/study/spring-security.md)
  - [CSRF](../review/study/csrf.md)

## `SecurityConfig` class filterChain() 설정

```java
@Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http
            .cors().configurationSource(corsConfigurationSource())
        .and()
            .sessionManagement()
            // SpringSecurity에 의해 생성되는 Session 없음 (Session 기반이 아님)
            .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
        .and()
            .csrf().disable() // JWT 사용하므로 disable
            .formLogin().disable() // Spring Security 기본 제공 LoginForm 해제
            .httpBasic().disable() // JWT 사용하므로 disable
            // 인증 예외가 발생하는 경우 호출
            .exceptionHandling()
            .authenticationEntryPoint(new RestAuthenticationEntryPoint())
        .and()
            .oauth2Login() 
            .authorizationEndpoint() // client 요청 시 경로 설정
            .baseUri("/oauth2/authorization")
        .and()
            .redirectionEndpoint() // client 측에서 인증 요청 응답 받는 시점의 경로 설정
            .baseUri("/*/oauth2/code/*")
        .and()
            .userInfoEndpoint() // DefaultOAuth2UserService class의 loadUser() 호출
            .userService(oAuth2UserService)
        .and()
            .successHandler(oAuth2AuthenticationSuccessHandler())
            .failureHandler(oAuth2AuthenticationFailureHandler())
    return http.build();
}
```

### CORS 설정

```java
// SecurityConfig.java
@Bean
public CorsConfigurationSource corsConfigurationSource() {
    UrlBasedCorsConfigurationSource corsConfigSource = new UrlBasedCorsConfigurationSource();

    CorsConfiguration corsConfig = new CorsConfiguration();
    corsConfig.setAllowedHeaders(Arrays.asList(corsProperties.getAllowedHeaders().split(",")));
    corsConfig.setAllowedMethods(Arrays.asList(corsProperties.getAllowedMethods().split(",")));
    corsConfig.setAllowedOrigins(Arrays.asList(corsProperties.getAllowedOrigins().split(",")));
    corsConfig.setAllowCredentials(true);
    corsConfig.setMaxAge(corsConfig.getMaxAge());

    // 모든 Url에 대해 설정한 CorsConfiguration 등록
    corsConfigSource.registerCorsConfiguration("/**", corsConfig);
    return corsConfigSource;
}

// CorsProperties.java
@Getter
@Setter
@Component
@ConfigurationProperties(prefix = "cors")
public class CorsProperties {
    private String allowedOrigins;
    private String allowedMethods;
    private String allowedHeaders;
    private Long maxAge;
}

// application.yml
cors:
  allowed-origins: 'http://localhost:3000'
  allowed-methods: GET,POST,PUT,DELETE,OPTIONS
  allowed-headers: '*'
  max-age: 3600
```

### `RestAuthenticationEntryPoint` class implements `AuthenticationEntryPoint`

인증 예외가 발생하는 경우 호출

```java
public class RestAuthenticationEntryPoint implements AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response,
        AuthenticationException authException) throws IOException, ServletException {
        authException.printStackTrace();
        response.sendError(
            HttpServletResponse.SC_UNAUTHORIZED,
            authException.getLocalizedMessage());
    }
}
```

### oauth2Login() 설정

`DefaultOAuth2UserService` class의 loadUser() 호출

```java
@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private final UserRepository userRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User user = super.loadUser(userRequest);

        return user;
    }
}
```

### oauth2Login().authorizationEndpoint().baseUri("/oauth2/authorization") 설정

이 옵션을 사용하면 client 쪽에서 IdP로 인증을 요청할 때 `/oauth2/authorization` 경로를 포함해야 한다([참고](https://docs.spring.io/spring-security/site/docs/5.0.7.RELEASE/reference/html/oauth2login-advanced.html))

![](images/dev22.png)

### redirectionEndpoint().baseUri("/*/oauth2/code/*") 설정

외부 IdP로부터의 인증이 끝난 후에 리다리렉트되는 endpoint 지정([참고](https://www.baeldung.com/spring-security-5-oauth2-login))

![](images/dev23.png)

## 프로젝트 실행 - Spring Security

![](images/dev21.png)

# 9. JWT 엑세스 토큰과 리프레시 토큰 생성

이 장에서는 유저가 IdP를 이용해 소셜 로그인에 성공한 후 엑세스 토큰과 리프레시 토큰을 발급하는 부분을 다룬다. 엑세스 토큰이 만료되어 만료된 토큰을 다시 발급받고 리프레시 토큰 갱신 여부를 결정하는 부분은 11장에서 다룬다.

## `SecurityConfig` 토큰 관련 업데이트

```java
@Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http
            .cors().configurationSource(corsConfigurationSource())
        .and()
            .sessionManagement()
            .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
        .and()
            .csrf().disable()
            .formLogin().disable()
            .httpBasic().disable()
            .exceptionHandling()
            .authenticationEntryPoint(new RestAuthenticationEntryPoint())
      			// 유효하지 않은 토큰/만료된 토큰에 대한 접근 거부 오류 핸들러 등록
            .accessDeniedHandler(tokenAccessDeniedHandler)
        .and()
            .oauth2Login()
            .authorizationEndpoint()
            .baseUri("/oauth2/authorization")
        .and()
            .redirectionEndpoint()
            .baseUri("/*/oauth2/code/*")
        .and()
            .userInfoEndpoint()
            .userService(oAuth2UserService)
        .and() // 인증 성공 및 실패에 대한 기능 추가
            .successHandler(oAuth2AuthenticationSuccessHandler())
            .failureHandler(oAuth2AuthenticationFailureHandler())
        .and() // 토큰 검증 필터 추가
            .addFilterBefore(tokenAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);
    return http.build();
}


@Bean
public OAuth2AuthenticationSuccessHandler oAuth2AuthenticationSuccessHandler() {
    return new OAuth2AuthenticationSuccessHandler(
        tokenProvider, // 토큰 발급/변환/인증 받아오기 기능 수행
        appProperties, // token 관련 property 변수들을 가져오기 위함
        refreshTokenRepository // DB - RefreshToken
    );
}

@Bean
public OAuth2AuthenticationFailureHandler oAuth2AuthenticationFailureHandler() {
    return new OAuth2AuthenticationFailureHandler();
}

// 토큰이 유효할 경우 security context holder에 인증 내역 추가
// tokenProvider가 토큰으로부터 인증 받아오는 역할 수행
@Bean
public TokenAuthenticationFilter tokenAuthenticationFilter() {
    return new TokenAuthenticationFilter(tokenProvider);
}
```

- **`addFilterBefore(<filter>, <class>)`**
  - UsernamePasswordAuthenticationFiler.class 직전에 tokenAuthenticationFilter()가 실행되도록 설정
  - tokenAuthenticationFilter()에서 tokenProvider가 token으로부터 UsernamePasswordAuthenticationToken을 생성, 그 다음에 UsernamePasswordAuthenticationFilter가 작동됨

## OAuth2AuthenticationSuccessHander - 토큰 발행 후 DB 저장

```java
@Override
public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
    Authentication authentication) throws IOException, ServletException {
    super.onAuthenticationSuccess(request, response, authentication);

    OAuth2AuthenticationToken authToken = (OAuth2AuthenticationToken) authentication;
    Provider provider = Provider.valueOf(authToken.getAuthorizedClientRegistrationId().toUpperCase());
    
    // OAuth2 provider로부터 받은 유저 정보 이용해 userInfo 객체 생성
    OidcUser user = (OidcUser) authentication.getPrincipal();
    OAuth2UserInfo userInfo = OAuth2UserInfoFactory.getOAuth2UserInfo(provider, user.getAttributes());
    Collection<? extends GrantedAuthority> authorities = ((OidcUser) authentication.getPrincipal()).getAuthorities();
    Role role = Role.isOf(authorities, Role.ADMIN) ? Role.ADMIN : Role.USER;

    // access token 발급
    LocalDateTime expiry = calExpiry(LocalDateTime.now(), appProperties.getAuth().getTokenExpiry());
    AuthToken accessToken = tokenProvider.createAuthToken(
        userInfo.getProviderId(),
        role,
        expiry);

    LocalDateTime refreshTokenExpiry = calExpiry(LocalDateTime.now(), appProperties.getAuth().getRefreshTokenExpiry());
    AuthToken refreshToken = tokenProvider.createAuthToken(
        appProperties.getAuth().getTokenSecret(),
        refreshTokenExpiry);

    // refresh token 발급, DB에 저장
    RefreshToken userRefreshToken = refreshTokenRepository.findByProviderId(userInfo.getProviderId());
    if (userRefreshToken == null) {
        userRefreshToken = RefreshToken.createRefreshToken(userInfo.getProviderId(), refreshToken.getToken());
        refreshTokenRepository.save(userRefreshToken);
    } else {
        userRefreshToken.updateRefreshToken(refreshToken.getToken());
    }
}
```

## AuthToken과 AuthTokenProvider

### AuthToken class

Token을 관리하는 class로 토큰 생성 및 검증(token claimsnull 검사), getTokenClaims() 수행

### AuthTokenProvider class

새로운 토큰 생성, String token으로부터 Token으로의 형 변환, AuthToken 객체로부터 AuthenticationToken으로의 변환 기능 수행

## HeaderUtil.java

```java
public static String getAccessToken(HttpServletRequest request) {
    String headerValue = request.getHeader(HEADER_AUTHORIZATION);

    if (headerValue == null) {
        return null;
    }

    if (headerValue.startsWith(TOKEN_PREFIX)) {
        return headerValue.substring(TOKEN_PREFIX.length());
    }

    return null;
}
```

HttpServerRequest의 header에서 토큰 관련 prefix("Bearer ")가 나오면 토큰만 추출해 반환하는 기능 수행

## 토큰 발급 후 실행 화면

### 브라우저 - 토큰 발급 후

![](images/dev24.png)

### User DB -  토큰 발급 후

![](images/dev25.png)

# 10. 리프레시 토큰 쿠키 설정

## `SecurityConfig` 리프레시 토큰 관련 업데이트

```java
@Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http
            .cors().configurationSource(corsConfigurationSource())
        .and()
            .sessionManagement()
            .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
        .and()
            .csrf().disable()
            .formLogin().disable()
            .httpBasic().disable()
            .exceptionHandling()
            .authenticationEntryPoint(new RestAuthenticationEntryPoint())
            .accessDeniedHandler(tokenAccessDeniedHandler)
        .and()
            .oauth2Login()
            .authorizationEndpoint()
            .baseUri("/oauth2/authorization")
            // 리프레시 토큰을 쿠키에 저장/삭제하기 위한 repository
            .authorizationRequestRepository(oAuth2CookieRepository())
        .and()
            .redirectionEndpoint()
            .baseUri("/*/oauth2/code/*")
        .and()
            .userInfoEndpoint()
            .userService(oAuth2UserService)
        .and()
            .successHandler(oAuth2AuthenticationSuccessHandler())
            .failureHandler(oAuth2AuthenticationFailureHandler())
        .and()
            .addFilterBefore(tokenAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

    return http.build();
}

// Authorization request와 관련된 state 저장
@Bean
public OAuth2CookieRepository oAuth2CookieRepository() {
    return new OAuth2CookieRepository();
}

@Bean
public OAuth2AuthenticationSuccessHandler oAuth2AuthenticationSuccessHandler() {
    return new OAuth2AuthenticationSuccessHandler(
        tokenProvider,
        appProperties,
        refreshTokenRepository,
        oAuth2CookieRepository() // 쿠키 레포지토리 추가
    );
}

@Bean
public OAuth2AuthenticationFailureHandler oAuth2AuthenticationFailureHandler() {
    // 쿠키 레포지토리 추가
    return new OAuth2AuthenticationFailureHandler(oAuth2CookieRepository());
}
```

## CookieUtil

쿠키 발급/가져오기/삭제/직렬화/역직렬화 기능 수행

## OAuth2CookieRepository

Authorization request와 관련된 state를 AuthorizationRequestRepository를 구현한 `OAuth2CookieRepository`에서 저장한다. 그리고 provider에서 제공한 AuthorizationUrl에서 허용/거부가 정해진다([참고](https://jyami.tistory.com/121)).

- 유저가 앱에 대한 권한을 허용하는 경우
  - 사용자를 callback url로 리다이렉트 시킴
  - 사용자 인증 코드도 백엔드가 가지고 있음
  - SuccessHandler 호출
- 유저가 앱에 대한 권한을 거부하는 경우
  - Callback url로 똑같이 리다이렉트 하지만 에러 발생
  - FailuerHandler 호출

## OAuth2AuthenticationSuccessHandler - 쿠키

```java
@Override
public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
    Authentication authentication) throws IOException, ServletException {
    Optional<String> redirectUri = CookieUtil.getCookie(request, REDIRECT_URI_PARAM_COOKIE_NAME)
        .map(Cookie::getValue);
    
    // redirectUri가 인증되었는지 검사
    if (isUnauthorizedUri(redirectUri)) {
        throw new IllegalArgumentException("Sorry! We've got an Unauthorized Redirect URI and can't proceed with the authentication");
    }

    String targetUrl = redirectUri.orElse(getDefaultTargetUrl());

    OAuth2AuthenticationToken authToken = (OAuth2AuthenticationToken) authentication;
    Provider provider = Provider.valueOf(authToken.getAuthorizedClientRegistrationId().toUpperCase());

    OidcUser user = (OidcUser) authentication.getPrincipal();
    OAuth2UserInfo userInfo = OAuth2UserInfoFactory.getOAuth2UserInfo(provider, user.getAttributes());
    Collection<? extends GrantedAuthority> authorities = ((OidcUser) authentication.getPrincipal()).getAuthorities();
    Role role = Role.isOf(authorities, Role.ADMIN) ? Role.ADMIN : Role.USER;

    LocalDateTime expiry = calExpiry(LocalDateTime.now(), appProperties.getAuth().getTokenExpiry());
    AuthToken accessToken = tokenProvider.createAuthToken(
        userInfo.getProviderId(),
        role,
        expiry);

    LocalDateTime refreshTokenExpiry = calExpiry(LocalDateTime.now(), appProperties.getAuth().getRefreshTokenExpiry());
    AuthToken refreshToken = tokenProvider.createAuthToken(
        appProperties.getAuth().getTokenSecret(),
        refreshTokenExpiry);

    RefreshToken userRefreshToken = refreshTokenRepository.findByProviderId(userInfo.getProviderId());
    if (userRefreshToken == null) {
        userRefreshToken = RefreshToken.createRefreshToken(userInfo.getProviderId(), refreshToken.getToken());
        refreshTokenRepository.save(userRefreshToken);
    } else {
        userRefreshToken.updateRefreshToken(refreshToken.getToken());
    }

    int cookieMaxAge = (int) appProperties.getAuth().getRefreshTokenExpiry() / 60;

    // 쿠키 갱신
    CookieUtil.deleteCookie(request, response, REFRESH_TOKEN);
    CookieUtil.addCookie(response, REFRESH_TOKEN, refreshToken.getToken(), cookieMaxAge);

    String targetUrl2 = UriComponentsBuilder.fromUriString(targetUrl)
        .queryParam("token", accessToken.getToken())
        .build()
        .toUriString();

    if (response.isCommitted()) {
        return;
    }
    
    // response가 정상적으로 커밋되지 않은 경우 저장된 쿠키 모두 삭제
    clearAuthenticationAttributes(request, response);
    getRedirectStrategy().sendRedirect(request, response, targetUrl2);
}
```

## OAuth2AuthenticationFailureHandler - 쿠키

```java
@Override
public void onAuthenticationFailure(
    HttpServletRequest request, HttpServletResponse response,
    AuthenticationException exception) throws IOException, ServletException {
    String targetUrl = CookieUtil.getCookie(request, REDIRECT_URI_PARAM_COOKIE_NAME)
        .map(Cookie::getValue)
        .orElse(("/"));

    exception.printStackTrace();
    
    // 미리 지정된 url로 리다이렉트 하거나 '/'로 리다리엑트
    targetUrl = UriComponentsBuilder.fromUriString(targetUrl)
        .queryParam("error", exception.getLocalizedMessage())
        .build()
        .toUriString();

    // 저장된 쿠키 모두 삭제
    oAuth2CookieRepository.removeAuthorizationRequestCookies(request, response);
  
    getRedirectStrategy().sendRedirect(request, response, targetUrl);
}
```

## 실행 화면 - 쿠키 발급


![](images/dev26.png)

# 11. 리프레시 토큰 발급

## `/api/v1/auth/refresh`

```java
@GetMapping("/refresh")
public ApiResponse refreshToken(HttpServletRequest request, HttpServletResponse response) {
    String accessToken = HeaderUtil.getAccessToken(request);
    AuthToken authToken = tokenProvider.convertAuthToken(accessToken);
  
    // access token 유효성 검사
    if (!authToken.validate()) {
        return ApiResponse.invalidAccessToken();
    }

    // access token이 만료되었는지 확인
    Claims claims = authToken.getExpiredTokenClaims();
    if (claims == null) {
        // 만료되지 않은 토큰인 경우 종료
        return ApiResponse.notExpiredTokenYet();
    }

    String providerId = claims.getSubject();
    Role role = Role.of(claims.get("role", String.class));
    
    // refresh token 가져오기
    String refreshToken = CookieUtil.getCookie(request, REFRESH_TOKEN)
        .map(Cookie::getValue)
        .orElse((null));
    AuthToken authRefreshToken = tokenProvider.convertAuthToken(refreshToken);

    // refresh token 유효성 검사
    if (!authRefreshToken.validate()) {
        return ApiResponse.invalidRefreshToken();
    }

    // refresh token이 db에 있는지 확인
    RefreshToken userRefreshToken = refreshTokenRepository.findByProviderIdAndRefreshToken(
        providerId, refreshToken);
    if (userRefreshToken == null) {
        return ApiResponse.invalidRefreshToken();
    }

    // 새로운 access token 발급
    LocalDateTime expiry = TimeUtil.calExpiry(LocalDateTime.now(), appProperties.getAuth().getRefreshTokenExpiry());
    AuthToken newAccessToken = tokenProvider.createAuthToken(
        providerId,
        role,
        expiry);

    Date now = new Date();
    long validTime = authRefreshToken.getTokenClaims().getExpiration().getTime() - now.getTime();
    
    // refresh 토큰 기간이 3일 이하인 경우 새로 갱신
    if (validTime <= THREE_DAYS_MSEC) {
        // refresh token 재발급
        LocalDateTime refreshTokenExpiry = TimeUtil.calExpiry(LocalDateTime.now(), appProperties.getAuth().getRefreshTokenExpiry());
        authRefreshToken = tokenProvider.createAuthToken(
            appProperties.getAuth().getTokenSecret(),
            refreshTokenExpiry);

        // DB에 저장
        userRefreshToken.updateRefreshToken(authRefreshToken.getToken());

        // 쿠키에 refresh token 정보 갱신
        int cookieMaxAge = (int) appProperties.getAuth().getRefreshTokenExpiry() / 60;
        CookieUtil.deleteCookie(request, response, REFRESH_TOKEN);
        CookieUtil.addCookie(response, REFRESH_TOKEN, authRefreshToken.getToken(), cookieMaxAge);
    }

    return ApiResponse.success("token", newAccessToken.getToken());
}
```

# 12. API 연동 및 로그인 확인

## 프론트엔드 코드 분석

![](images/dev27.png)

## UserController 업데이트

```java
@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping
    public ApiResponse<UserResponseDto> describeAuthenticatedUser() {
        org.springframework.security.core.userdetails.User principal = (org.springframework.security.core.userdetails.User)
            SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        User user = userService.getUserByProviderId(principal.getUsername());
        return ApiResponse.success("user", UserResponseDto.from(user));
    }
}
```



### 수정해야 할 부분

- AuthController.java
  - 리프레시 토큰 유효성 검사 부분
- AuthToken.java

  ```java
  public Claims getExpiredTokenClaims() {
      try {
          Jwts.parserBuilder()
                  .setSigningKey(key)
                  .build()
                  .parseClaimsJws(token)
                  .getBody();
      } catch (ExpiredJwtException e) {
          log.info("Expired JWT token.");
          return e.getClaims();
      }
      return null;
  }
  ```
