# 
# Thanks to  Joseph Wilkicki for submitting this file's contents
#
# In your Quartz properties file, you'll need to set 
# org.quartz.jobStore.driverDelegateClass = org.quartz.impl.jdbcjobstore.HSQLDBDelegate
#
# Some users report the need to change the fields
# with datatype "OTHER" to datatype "BINARY" with
# particular versions (e.g. 1.7.1) of HSQLDB
#

CREATE TABLE qrtz_job_details
(
JOB_NAME LONGVARCHAR(80) NOT NULL,
JOB_GROUP LONGVARCHAR(80) NOT NULL,
DESCRIPTION LONGVARCHAR(120) NULL,
JOB_CLASS_NAME LONGVARCHAR(128) NOT NULL,
IS_DURABLE LONGVARCHAR(1) NOT NULL,
IS_VOLATILE LONGVARCHAR(1) NOT NULL,
IS_STATEFUL LONGVARCHAR(1) NOT NULL,
REQUESTS_RECOVERY LONGVARCHAR(1) NOT NULL,
JOB_DATA OTHER NULL,
PRIMARY KEY (JOB_NAME,JOB_GROUP)
);

CREATE TABLE qrtz_job_listeners
(
JOB_NAME LONGVARCHAR(80) NOT NULL,
JOB_GROUP LONGVARCHAR(80) NOT NULL,
JOB_LISTENER LONGVARCHAR(80) NOT NULL,
PRIMARY KEY (JOB_NAME,JOB_GROUP,JOB_LISTENER),
FOREIGN KEY (JOB_NAME,JOB_GROUP)
REFERENCES QRTZ_JOB_DETAILS(JOB_NAME,JOB_GROUP)
);

CREATE TABLE qrtz_triggers
(
TRIGGER_NAME LONGVARCHAR(80) NOT NULL,
TRIGGER_GROUP LONGVARCHAR(80) NOT NULL,
JOB_NAME LONGVARCHAR(80) NOT NULL,
JOB_GROUP LONGVARCHAR(80) NOT NULL,
IS_VOLATILE LONGVARCHAR(1) NOT NULL,
DESCRIPTION LONGVARCHAR(120) NULL,
NEXT_FIRE_TIME NUMERIC(13) NULL,
PREV_FIRE_TIME NUMERIC(13) NULL,
TRIGGER_STATE LONGVARCHAR(16) NOT NULL,
TRIGGER_TYPE LONGVARCHAR(8) NOT NULL,
START_TIME NUMERIC(13) NOT NULL,
END_TIME NUMERIC(13) NULL,
CALENDAR_NAME LONGVARCHAR(80) NULL,
MISFIRE_INSTR NUMERIC(2) NULL,
PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (JOB_NAME,JOB_GROUP)
REFERENCES QRTZ_JOB_DETAILS(JOB_NAME,JOB_GROUP)
);

CREATE TABLE qrtz_simple_triggers
(
TRIGGER_NAME LONGVARCHAR(80) NOT NULL,
TRIGGER_GROUP LONGVARCHAR(80) NOT NULL,
REPEAT_COUNT NUMERIC(7) NOT NULL,
REPEAT_INTERVAL NUMERIC(12) NOT NULL,
TIMES_TRIGGERED NUMERIC(7) NOT NULL,
PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE qrtz_cron_triggers
(
TRIGGER_NAME LONGVARCHAR(80) NOT NULL,
TRIGGER_GROUP LONGVARCHAR(80) NOT NULL,
CRON_EXPRESSION LONGVARCHAR(80) NOT NULL,
TIME_ZONE_ID LONGVARCHAR(80),
PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE qrtz_blob_triggers
(
TRIGGER_NAME LONGVARCHAR(80) NOT NULL,
TRIGGER_GROUP LONGVARCHAR(80) NOT NULL,
BLOB_DATA OTHER NULL,
PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE qrtz_trigger_listeners
(
TRIGGER_NAME LONGVARCHAR(80) NOT NULL,
TRIGGER_GROUP LONGVARCHAR(80) NOT NULL,
TRIGGER_LISTENER LONGVARCHAR(80) NOT NULL,
PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_LISTENER),
FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE qrtz_calendars
(
CALENDAR_NAME LONGVARCHAR(80) NOT NULL,
CALENDAR OTHER NOT NULL,
PRIMARY KEY (CALENDAR_NAME)
); 

CREATE TABLE qrtz_paused_trigger_grps
  (
    TRIGGER_GROUP  LONGVARCHAR(80) NOT NULL, 
    PRIMARY KEY (TRIGGER_GROUP)
);

CREATE TABLE qrtz_fired_triggers 
  (
    ENTRY_ID LONGVARCHAR(95) NOT NULL,
    TRIGGER_NAME LONGVARCHAR(80) NOT NULL,
    TRIGGER_GROUP LONGVARCHAR(80) NOT NULL,
    IS_VOLATILE LONGVARCHAR(1) NOT NULL,
    INSTANCE_NAME LONGVARCHAR(80) NOT NULL,
    FIRED_TIME NUMERIC(13) NOT NULL,
    STATE LONGVARCHAR(16) NOT NULL,
    JOB_NAME LONGVARCHAR(80) NULL,
    JOB_GROUP LONGVARCHAR(80) NULL,
    IS_STATEFUL LONGVARCHAR(1) NULL,
    REQUESTS_RECOVERY LONGVARCHAR(1) NULL,
    PRIMARY KEY (ENTRY_ID)
);

CREATE TABLE qrtz_scheduler_state 
  (
    INSTANCE_NAME LONGVARCHAR(80) NOT NULL,
    LAST_CHECKIN_TIME NUMERIC(13) NOT NULL,
    CHECKIN_INTERVAL NUMERIC(13) NOT NULL,
    RECOVERER LONGVARCHAR(80) NULL,
    PRIMARY KEY (INSTANCE_NAME)
);

CREATE TABLE qrtz_locks
  (
    LOCK_NAME  LONGVARCHAR(40) NOT NULL, 
    PRIMARY KEY (LOCK_NAME)
);


INSERT INTO qrtz_locks values('TRIGGER_ACCESS');
INSERT INTO qrtz_locks values('JOB_ACCESS');
INSERT INTO qrtz_locks values('CALENDAR_ACCESS');
INSERT INTO qrtz_locks values('STATE_ACCESS');
INSERT INTO qrtz_locks values('MISFIRE_ACCESS');

commit;

