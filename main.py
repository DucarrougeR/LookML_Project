#!/usr/bin/python

import pandas as pd 
import numpy as np 
import os, re 
import psycopg2

from data_clean import date_formatting
from py2postgres import table_creating

if __name__ == "__main__":
	date_formatting()
	print('data formatted')

	table_creating()
	print('tables created')

####################################################################################################
	# test that each table is created and populated:
	# conn = psycopg2.connect(host="localhost",database="looker_project", user="postgres", password="") 
	# cur = conn.cursor()

	# cur.execute("SELECT * FROM sub_trip")
	# print(cur.fetchone())
	# cur.execute("SELECT * FROM sub_status")
	# print(cur.fetchone())
	# cur.execute("SELECT * FROM sub_weather")
	# print(cur.fetchone())
	# cur.execute("SELECT * FROM sub_station")
	# print(cur.fetchone())

	# cur.close()
	# conn.close()