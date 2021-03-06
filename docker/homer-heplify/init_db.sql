CREATE USER 'homer_user'@'%' IDENTIFIED BY 'homer_password';
GRANT ALL ON homer_configuration.* TO 'homer_user'@'%';
GRANT ALL ON homer_statistic.* TO 'homer_user'@'%';
GRANT ALL ON homer_data.* TO 'homer_user'@'%';
GRANT ALL ON homer_data.* TO 'homer_user'@'%';


SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

CREATE DATABASE homer_data;
CREATE DATABASE homer_configuration;
CREATE DATABASE homer_statistic;

USE homer_configuration;

--
-- Database: `homer_configuration`
--

-- --------------------------------------------------------

--
-- Table structure for table `alias`
--

CREATE TABLE IF NOT EXISTS `alias` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `gid` int(5) NOT NULL DEFAULT 0,
  `ip` varchar(80) NOT NULL DEFAULT '',
  `port` int(10) NOT NULL DEFAULT '0',
  `capture_id` varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(100) NOT NULL DEFAULT '',
  `is_stp` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `host_2` (`ip`,`port`,`capture_id`),
  KEY `host` (`ip`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `alias`
--

INSERT INTO `alias` (`id`, `gid`, `ip`, `port`, `capture_id`, `alias`, `status`, `created`) VALUES
(1, 10, '192.168.0.30', 0, 'homer01', 'proxy01', 1, '2014-06-12 20:36:50'),
(2, 10, '192.168.0.4', 0, 'homer01', 'acme-234', 1, '2014-06-12 20:37:01'),
(22, 10, '127.0.0.1:5060', 0, 'homer01', 'sip.local.net', 1, '2014-06-12 20:37:01');

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE IF NOT EXISTS `group` (
  `gid` int(10) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT '',
  UNIQUE KEY `gid` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`gid`, `name`) VALUES (10, 'Administrator');

-- --------------------------------------------------------

--
-- Table structure for table `link_share`
--

CREATE TABLE IF NOT EXISTS `link_share` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT 0,
  `uuid` varchar(120) NOT NULL DEFAULT '',
  `data` text NOT NULL,
  `expire` datetime NOT NULL DEFAULT '2032-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

-- --------------------------------------------------------

--
-- Table structure for table `node`
--

CREATE TABLE IF NOT EXISTS `node` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `host` varchar(80) NOT NULL DEFAULT '',
  `dbname` varchar(100) NOT NULL DEFAULT '',
  `dbport` varchar(100) NOT NULL DEFAULT '',
  `dbusername` varchar(100) NOT NULL DEFAULT '',
  `dbpassword` varchar(100) NOT NULL DEFAULT '',
  `dbtables` varchar(100) NOT NULL DEFAULT 'sip_capture',
  `name` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `host_2` (`host`),
  KEY `host` (`host`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `node`
--

INSERT INTO `node` (`id`, `host`, `dbname`, `dbport`, `dbusername`, `dbpassword`, `dbtables`, `name`, `status`) VALUES
(1, '127.0.0.1', 'homer_data', '3306', 'homer_user', 'mysql_password', 'sip_capture', 'homer01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE IF NOT EXISTS `setting` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT '0',
  `param_name` varchar(120) NOT NULL DEFAULT '',
  `param_value` text NOT NULL,
  `valid_param_from` datetime NOT NULL DEFAULT '2012-01-01 00:00:00',
  `valid_param_to` datetime NOT NULL DEFAULT '2032-12-01 00:00:00',
  `param_prio` int(2) NOT NULL DEFAULT '10',
  `active` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_2` (`uid`,`param_name`),
  KEY `param_name` (`param_name`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `uid`, `param_name`, `param_value`, `valid_param_from`, `valid_param_to`, `param_prio`, `active`) VALUES
(1, 1, 'timerange', '{"from":"2015-05-26T18:34:42.654Z","to":"2015-05-26T18:44:42.654Z"}', '2012-01-01 00:00:00', '2032-12-01 00:00:00', 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gid` int(10) NOT NULL DEFAULT '10',
  `grp` varchar(200) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `firstname` varchar(250) NOT NULL DEFAULT '',
  `lastname` varchar(250) NOT NULL DEFAULT '',
  `email` varchar(250) NOT NULL DEFAULT '',
  `department` varchar(100) NOT NULL DEFAULT '',
  `regdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastvisit` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `login` (`username`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `gid`, `grp`, `username`, `password`, `firstname`, `lastname`, `email`, `department`, `regdate`, `lastvisit`, `active`) VALUES
(1, 10, 'users,admins', 'admin', PASSWORD('test123'), 'Admin', 'Admin', 'admin@test.com', 'Voice Enginering', '2012-01-19 00:00:00', '2015-05-29 07:17:35', 1),
(2, 10, 'users', 'noc', PASSWORD('123test'), 'NOC', 'NOC', 'noc@test.com', 'Voice NOC', '2012-01-19 00:00:00', '2015-05-29 07:17:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_menu`
--

CREATE TABLE IF NOT EXISTS `user_menu` (
  `id` varchar(125) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(200) NOT NULL DEFAULT '',
  `icon` varchar(100) NOT NULL DEFAULT '',
  `weight` int(10) NOT NULL DEFAULT '10',
  `active` int(1) NOT NULL DEFAULT '1',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_menu`
--

INSERT INTO `user_menu` (`id`, `name`, `alias`, `icon`, `weight`, `active`) VALUES
('_1426001444630', 'SIP Search', 'search', 'fa-search', 10, 1),
('_1427728371642', 'Home', 'home', 'fa-home', 1, 1),
('_1431721484444', 'Alarms', 'alarms', 'fa-warning', 20, 1);


--
-- Table structure for table `api_auth_key`
--

CREATE TABLE IF NOT EXISTS `api_auth_key` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `authkey` varchar(200) NOT NULL,
  `source_ip` varchar(200) NOT NULL DEFAULT '0.0.0.0',
  `startdate` datetime NOT NULL DEFAULT '2012-01-01 00:00:00',
  `stopdate` datetime NOT NULL DEFAULT '2032-01-01 00:00:00',
  `userobject` varchar(250) NOT NULL,
  `description` varchar(200) NOT NULL DEFAULT '',
  `lastvisit` datetime NOT NULL DEFAULT '2012-01-01 00:00:00',
  `enable` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `authkey` (`authkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Table structure for statistics
--

USE homer_statistic;

CREATE TABLE IF NOT EXISTS `stats_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_date` timestamp NOT NULL DEFAULT '1971-01-01 00:00:01',
  `type` varchar(50) NOT NULL DEFAULT '',
  `total` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`from_date`),
  UNIQUE KEY `datemethod` (`from_date`,`to_date`,`type`),
  KEY `from_date` (`from_date`),
  KEY `to_date` (`to_date`),
  KEY `method` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`from_date`))
(PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */ ;

CREATE TABLE IF NOT EXISTS `stats_method` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_date` timestamp NOT NULL DEFAULT '1971-01-01 00:00:01',
  `method` varchar(50) NOT NULL DEFAULT '',
  `auth` tinyint(1) NOT NULL DEFAULT '0',
  `cseq` varchar(100) NOT NULL DEFAULT '',
  `totag` tinyint(1) NOT NULL DEFAULT 0,
  `total` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`from_date`),
  UNIQUE KEY `datemethod` (`from_date`,`to_date`,`method`,`auth`,`totag`,`cseq`),
  KEY `from_date` (`from_date`),
  KEY `to_date` (`to_date`),
  KEY `method` (`method`),
  KEY `completed` (`cseq`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`from_date`))
(PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */ ;

USE mysql;
INSERT INTO `user` VALUES ('localhost','homer_user','*D0F60D1E3C6C124FEEB76527E00A9380C37643EE','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,'mysql_native_password','','N');
INSERT INTO `db` VALUES ('localhost','homer_configuration','homer_user','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost','homer_statistic','homer_user','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost','homer_data','homer_user','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y');

SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION';
