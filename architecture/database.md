# 데이터베이스 설계

마지막 업데이트 날짜: 2023-08-25 <br>
작성자: 박우현, 김예진

> **목차**
>
> 1. [WeHee에서 사용하는 데이터베이스](#1-wehee에서-사용하는-데이터베이스)
> 2. [ERD](#2-erd)
>    1. [WeHee ERD](#wehee-erd)
>    2. [우리집(게시판) 관련 확장된 ERD](#우리집-게시판-관련-확장된-erd)
> 3. [데이터베이스 관련 심화 기능 설계](#3-데이터베이스-관련-심화-기능-설계)
>    1. [삭제된 게시글/답글/댓글 테이블 이미그레이션](#삭제된-게시글답글댓글-테이블-이미그레이션)

### EXTERNAL LINKS

- [[erdcloud] 게시판 관련 ERD](https://www.erdcloud.com/d/98PARD72QWATyZNbN)
- [[Notion] 사용자 및 라운지 테이블 설계표](https://www.notion.so/lemonade-log/MBTI-DB-498895472def44bfa698757ae62b091b)
- [[Notion] 라운지 API 명세](https://www.notion.so/lemonade-log/API-380dbc4018f6414ba472727b684d37da)

# 1. WeHee에서 사용하는 데이터베이스

| MySQL          | Redis                         |
| -------------- | ----------------------------- |
| 유저           | 채팅방에서의 마지막 채팅 저장 |
| 우리집(게시판) |                               |
| 채팅           |                               |
| 보이스룸       |                               |

# 2. ERD

WeHee에서 사용되는 테이블 생성 코드는 [wehee_create.sql](../mannual/data/wehee_create.sql)에서 확인하실 수 있습니다.

## WeHee ERD

![](C:\Users\SSAFY\Desktop\Yejining\WeHeeDocs\architecture\images\architecture01.png)

## 우리집(게시판) 관련 확장된 ERD

![](C:\Users\SSAFY\Desktop\Yejining\WeHeeDocs\architecture\images\architecture02.png)

# 3. 데이터베이스 관련 심화 기능 설계

## 삭제된 게시글/답글/댓글 테이블 이미그레이션

- 목적: 이용자 보호 및 데이터베이스 조회 성능 향상을 위함
