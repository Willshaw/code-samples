####################################
#                                  #
#  Example queries to demonsrate   #
#  how SELECTing a NULL value is   #
#  converting it into a 0 during a #
#  INSERT...SELECT statement       #
#                                  #
####################################

# recreate an empty example price table
# to make sure our example is fresh, no old data
DROP TABLE IF EXISTS `price`;
CREATE TABLE `price`
(
    `note` TEXT,
    `price` FLOAT NULL
);

# insert 2 values, an actual number and a NULL value,
# label them accordingly
INSERT INTO `price` VALUES
    ( "100 number", 100 ),
    ( "NULL row", NULL );

# again recreate the test table,
# where we'll see the some of the NULL values become 0
# THERE IS NO DEFAULT VALUE BEING SET AND WE'RE SAYING NOT NULL
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`
(
    `note` TEXT,
    `test` FLOAT NOT NULL
);

# Insert using a SELECT, but we're selecting fixed values
# we're not selecting from another table
# this converts the NULL value into a 0
INSERT INTO `test`
SELECT "SELECT NULL", NULL;

# Now select all the values from the price table
# which includes row with a NULL price, which is converted into 0
INSERT INTO `test`
SELECT `note`, `price` from `price`;

# now try and insert a NULL _without_ using select first,
# this fails as I would expect
INSERT INTO `test`
VALUES ( "VALUES NULL", NULL );

# Error recieved:
# [Err] 1048 - Column 'test' cannot be null
