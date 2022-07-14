from flask import Flask, render_template #Import the Flask class and render_template
import pymysql #Import pymysql module
 
app = Flask(__name__) #Create an instance of this class


@app.cli.command() #Use the command() decorator to create a custom command to add script to crontab
@app.route('/') #Use the route() decorator to tell Flask what URL should trigger our function
def hello_world():
    #Function to connect to database and send mysql request
    def sql_request(sql):
        try:
            #Use connect() to connect to database with requre credentials
            conn = pymysql.connect(host='db.test.net', user='web', password='Qwerty58', database='Articles_DB')
            #A cursor is created from the conn connection object. The cursor is used to move records from the result set
            cur = conn.cursor()
            #The execute() cursor method is called to use the SQL command
            cur.execute(sql)
            #The fetchall() method calls all rows from the query result set
            answer = cur.fetchall()
            return answer
        #Exception in case of connection error
        except pymysql.err.OperationalError as oe:
            print("OperationalError!{0}".format(oe))

    articles_table = sql_request("select * from Articles")
    magazines_table = sql_request("select * from magazines")
    article_types_table = sql_request("select * from article_types")
    author_table = sql_request("select * from author")
    try:
        #Use write() method to write output of render_template() in a file
        render_template('index.html', content=articles_table, content1=magazines_table, content2=article_types_table, content3=author_table)
    #Exception in case of empty variables
    except TypeError as te:
        print("TypeError!{0}".format(te))
