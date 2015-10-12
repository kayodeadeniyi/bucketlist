<h1> Bucketlist API </h1>
This application centers on creating an API. This is my checkpoint 3 project for Andela Rails' track. The given task is shown below

<h2> Problem Description </h2>
In this exercise you will be required to create a Rails API for a bucket list service. Specification for the API is shown below. You may use any database you prefer for this assignment.

#####EndPoints     &&                Functionality
* POST /auth/login,            Logs a user in

* GET /auth/logout,            Logs a user out

* POST /bucketlists/,          Create a new bucket list

* GET /bucketlists/,           List all the created bucket lists

* GET /bucketlist/<id>,        Get single bucket list

* POST /bucketlist/<id>,       Add a new item to this bucket list

* PUT /bucketlist/<id>,        Update this bucket list

* DELETE /bucketlist/<id>,     Delete this single bucket list


####Task 0 - Create API
In this task you are required to create the API described above using Rails API. The JSON data model for a bucket list and a bucket list item is shown below.

{

	id: 1,

	name: “BucketList1”,

	items: [

		{

      id: 1,

      name: “I need to do X”,

      date_created: “2015-08-12 11:57:23”,

      date_modified: “2015-08-12 11:57:23”,

      done: False

    }

    ],

	date_created: “2015-08-12 11:57:23”,

	date_modified: “2015-08-12 11:57:23”,

	created_by: “1113456”

}


####Task 1 - Implement Token Based Authentication
For this task, you are required to implement Token Based Authentication for the API such that some methods are not accessible via unauthenticated users. Access control mapping is listed below.


#####EndPoints        &&            Public Access
* POST /auth/login,              TRUE

* GET /auth/logout,              FALSE

* POST /bucketlists/,            FALSE

* GET /bucketlists/,             TRUE

* GET /bucketlist/<id>,          FALSE

* POST /bucketlist/<id>,         FALSE

* PUT /bucketlist/<id>,          FALSE

* DELETE /bucketlist/<id>,       FALSE



<strong>Note: GET /bucketlists/ should return an array of bucketlist containing name and id only.</strong>

####Task 2 - Version your API


[![Coverage Status](https://coveralls.io/repos/andela-kadeniyi/bucketlist/badge.svg?branch=master&service=github)](https://coveralls.io/github/andela-kadeniyi/bucketlist?branch=master)

To read the documentation and interact with the API, <a href="http://abucketlist.herokuapp.com/">Click here</a>


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/andela-kadeniyi/bucketlist/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

