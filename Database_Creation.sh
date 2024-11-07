source ~/.bash_profile

source $commonConfigurationFilePath
dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL


CREATE TABLE if not exists sms_usage_1205 (
  id int NOT NULL AUTO_INCREMENT,
  processed_on timestamp DEFAULT CURRENT_TIMESTAMP,
  sms_recieved_date timestamp NULL DEFAULT NULL,
  short_code int DEFAULT NULL,
  msisdn varchar(20) DEFAULT NULL,
  request_from_customer varchar(250) DEFAULT NULL,
  response_date_time timestamp NULL DEFAULT NULL,
  response varchar(250) DEFAULT NULL,
  request_lang varchar(20) DEFAULT NULL,
  response_lang varchar(20) DEFAULT NULL,
  operator varchar(20) DEFAULT NULL,
  file_name varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE if not exists ussd_usage_1205 (
  id int NOT NULL AUTO_INCREMENT,
  processed_on timestamp DEFAULT CURRENT_TIMESTAMP,
  modified_on timestamp DEFAULT CURRENT_TIMESTAMP,
  request_init_date timestamp NULL DEFAULT NULL,
  request_type varchar(10) DEFAULT '',
  ussd_session_id varchar(100) DEFAULT '',
  msisdn varchar(20) DEFAULT '',
  imsi varchar(20) DEFAULT '',
  input varchar(255) DEFAULT '',
  session_end_date_time timestamp NULL DEFAULT NULL,
  reason_session_close varchar(250) DEFAULT '',
  response_lang varchar(20) DEFAULT '',
  operator varchar(20) DEFAULT '',
  file_name varchar(50) DEFAULT '',
  PRIMARY KEY (id)
);

insert into cfg_feature_alert (alert_id, description, feature) values ('alert5500', 'The file does not exists for USSD summary.','USSD Summary');
insert into cfg_feature_alert (alert_id, description, feature) values ('alert5501', 'The processing failed for USSD file <e> for operator <process_name>','USSD Summary');
insert into cfg_feature_alert (alert_id, description, feature) values ('alert5502', 'The processing failed for USSD summary.','USSD Summary');
insert into cfg_feature_alert (alert_id, description, feature) values ('alert5600', 'The file does not exists for SMS summary.','SMS Summary');
insert into cfg_feature_alert (alert_id, description, feature) values ('alert5601', 'The processing failed for SMS file <e> for operator <process_name>','SMS Summary');
insert into cfg_feature_alert (alert_id, description, feature) values ('alert5602', 'The processing failed for SMS summary.','SMS Summary');


EOFMYSQL
