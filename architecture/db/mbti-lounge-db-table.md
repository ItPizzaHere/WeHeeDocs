
| MBTI | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| MBTI번호 | mbti_id | INT | PK |
| MBTI | name | VARCHAR(4) | NOT NULL |

| 게시글(post) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 글번호 | post_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 라운지번호 | post_mbti_id | INT | FK REFERENCES mbti_id(MBTI), NOT NULL |
| 제목 | title | VARCHAR(30) | NOT NULL |
| 내용 | content | TEXT | NOT NULL |
| 작성자 | post_user_id | INT UNSIGNED | FK REFERENCES user_id(user) |
| 좋아요수 | like_count | MEDIUMINT | NOT NULL DEFAULT 0 |
| 조회수 | hit | INT UNSIGNED | NOT NULL DEFAULT 0 |
| 댓글수 | comment_count | INT UNSIGNED | NOT NULL DEFAULT 0 |
| 게시시간 | upload_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| 삭제여부 | is_deleted | BOOL | DEFAULT FALSE |
| 투표 존재여부 | has_vote | BOOL | DEFAULT FALSE |

| 좋아요(like) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 게시글번호 | like_post_id | INT UNSIGNED | PK, FK REFERENCES post_id(post) |
| 사용자ID | like_user_id | INT UNSIGNED | PK, FK REFERENCES user_id(user) |

| 댓글(comment) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 댓글번호 | comment_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 게시글번호 | comment_post_id | INT UNSIGNED | FK REFERENCES post_id(post), NOT NULL |
| 작성자 | comment_user_id | INT UNSIGNED | FK REFERENCES user_id(user), NOT NULL |
| 내용 | content | TEXT | NOT NULL |
| 게시시각 | upload_time | TIMESTAMP | NOT NULL DEFAULT CURRENT_TIMESTAMP |
| 게시상태 | state | INT | NOT NULL DEFAULT 0 |

| 답글(reply) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 답글번호 | reply_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 댓글번호 | reply_comment_id | INT UNSIGNED | FK REFERENCES comment_id(comment), NOT NULL |
| 게시글번호 | reply_post_id | INT UNSIGNED | FK REFERENCES post_id(post), NOT NULL |
| 작성자 | reply_user_id | INT UNSIGNED | FK REFERENCES user_id(user), NOT NULL |
| 내용 | content | TEXT | NOT NULL |
| 게시시각 | upload_time | TIMESTAMP | NOT NULL DEFAULT CURRENT_TIMESTAMP |
| 게시상태 | state | INT | NOT NULL DEFAULT 0 |

| 투표(vote) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 투표번호 | vote_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 게시글번호 | vote_post_id | INT UNSIGNED | FK REFERENCES post_id(post), NOT NULL |
| 제목 | title | VARCHAR(30) | NOT NULL |

| 투표선택지(vote_select) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 선택지번호 | vote_select_id | INT UNSIGNED | PK |
| 투표번호 | vote_select_vote_id | INT UNSIGNED | PK, FK REFERENCES vote_id(vote) |
| 선택지 | title | VARCHAR(100) | NOT NULL |

| 투표자(voter) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 투표번호 | voter_vote_id | INT UNSIGNED | PK, FK REFERENCES vote_id(vote) |
| 선택지번호 | voter_vote_select_id | INT UNSIGNED | PK, FK REFERENCES vote_select_id(vote_seLect) |
| 사용자 | voter_user_id | INT UNSIGNED | PK, FK REFERENCES user_id(user) |

| 알림(notification) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 알림번호 | notification_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 사용자(알림 받는 사람) | notification_receiver_user_id | INT UNSIGNED | FK REFERENCES user_id(user) |
| 댓글/대댓글 작성자(알림 울리게 한 사람) | notification_sender_user_id | INT UNSIGNED | FK REFERENCES user_id(user) |
| 댓글/대댓글 작성내용 | comment | TEXT |  |
| 댓글/대댓글 작성시간 | upload_time | TIMESTAMP |  |
| 게시글/댓글 여부 | is_post | BOOL |  |
| 게시글/댓글 번호 | origin_post_id | INT UNSIGNED |  |
| 열람 여부 | browsed | BOOL | DEFAULT FALSE |

| 신고(declare) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 글 유형 | declare_type | INT | PK |
| 글 번호 | declare_post_id | INT UNSIGNED | PK |
| 신고자 | delclare_user_id | INT UNSIGNED | PK |

| 삭제된 게시글(deleted_post) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | deleted_post_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 글번호 | post_id | INT UNSIGNED |  |
| 라운지번호 | post_mbti_id | INT |  |
| 제목 | title | VARCHAR(30) |  |
| 내용 | content | TEXT |  |
| 작성자 | post_user_id | INT UNSIGNED |  |
| 좋아요수 | like_count | MEDIUMINT |  |
| 조회수 | hit | INT UNSIGNED |  |
| 댓글수 | comment_count | INT UNSIGNED |  |
| 게시시간 | upload_time | TIMESTAMP |  |
| 삭제여부 | is_deleted | BOOL |  |
| 투표 존재여부 | has_vote | BOOL |  |

| 삭제된 댓글(deleted_comment) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | deleted_comment_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 댓글번호 | comment_id | INT UNSIGNED |  |
| 게시글번호 | comment_post_id | INT UNSIGNED |  |
| 작성자 | comment_user_id | INT UNSIGNED |  |
| 내용 | content | TEXT |  |
| 게시시각 | upload_time | TIMESTAMP |  |
| 게시상태 | state | INT |  |

| 삭제된 답글(deleted_reply) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | deleted_reply_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 답글번호 | reply_id | INT UNSIGNED |  |
| 댓글번호 | reply_comment_id | INT UNSIGNED |  |
| 게시글번호 | reply_post_id | INT UNSIGNED |  |
| 작성자 | reply_user_id | INT UNSIGNED |  |
| 내용 | content | TEXT |  |
| 게시시각 | upload_time | TIMESTAMP |  |
| 게시상태 | state | INT |  |

| 삭제된 투표(deleted_vote) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | deleted_vote_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 투표번호 | vote_id | INT UNSIGNED |  |
| 게시글번호 | vote_post_id | INT UNSIGNED |  |
| 제목 | title | VARCHAR(30) |  |

| 삭제된 투표선택지(deleted_vote_select) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | deleted_vote_select_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 선택지번호 | vote_select_id | INT UNSIGNED |  |
| 투표번호 | vote_select_vote_id | INT UNSIGNED |  |
| 선택지 | title | VARCHAR(100) |  |

| 삭제된 투표자(deleted_voter) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | delete_voter_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 투표번호 | voter_vote_id | INT UNSIGNED |  |
| 선택지번호 | voter_vote_select_id | INT UNSIGNED |  |
| 사용자 | voter_user_id | INT UNSIGNED |  |
