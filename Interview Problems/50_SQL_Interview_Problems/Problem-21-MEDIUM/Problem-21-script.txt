/* --------------------------------------------------------------------------- */
-- Acceptance Rate By Date
-- What is the overall friend acceptance rate by date? Your output should have the rate of acceptances by the date the request was sent. Order by the earliest date to latest.
-- Assume that each friend request starts by a user sending (i.e., user_id_sender) a friend request to another user (i.e., user_id_receiver) that's logged in the table with action = 'sent'. If the request is accepted, the table logs action = 'accepted'. If the request is not accepted, no record of action = 'accepted' is logged.

drop table fb_friend_requests;
create table fb_friend_requests
    (
        user_id_sender      varchar(20),
        user_id_receiver    varchar(20),
        date                date,
        action              varchar(20)
    );

insert into fb_friend_requests values ('ad4943sdz','948ksx123d','2020-01-04','sent');
insert into fb_friend_requests values ('ad4943sdz','948ksx123d','2020-01-06','accepted');
insert into fb_friend_requests values ('dfdfxf9483','9djjjd9283','2020-01-04','sent');
insert into fb_friend_requests values ('dfdfxf9483','9djjjd9283','2020-01-15','accepted');
insert into fb_friend_requests values ('ffdfff4234234','lpjzjdi4949','2020-01-06','sent');
insert into fb_friend_requests values ('fffkfld9499','993lsldidif','2020-01-06','sent');
insert into fb_friend_requests values ('fffkfld9499','993lsldidif','2020-01-10','accepted');
insert into fb_friend_requests values ('fg503kdsdd','ofp049dkd','2020-01-04','sent');
insert into fb_friend_requests values ('fg503kdsdd','ofp049dkd','2020-01-10','accepted');
insert into fb_friend_requests values ('hh643dfert','847jfkf203','2020-01-04','sent');
insert into fb_friend_requests values ('r4gfgf2344','234ddr4545','2020-01-06','sent');
insert into fb_friend_requests values ('r4gfgf2344','234ddr4545','2020-01-11','accepted');
COMMIT;
