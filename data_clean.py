#!/usr/bin/python
import pandas as pd
import numpy as np
import re

def date_formatting():

	# Split Dates Format in date and time
	trip = pd.read_csv("~/Desktop/Looker_Project/trip.csv")
	trip['start_date'] = pd.to_datetime(trip['start_date'])
	#keeping only correct zip code (5 digits in California)
	trip = trip.dropna(subset=['zip_code'])
	trip = trip[trip.zip_code.str.startswith('9')]	
	trip['end_date'] = pd.to_datetime(trip['end_date'])
	print(trip[zip_code].unique())
####################################################################################################
	weather = pd.read_csv("~/Desktop/Looker_Project/weather.csv")
	weather = weather.drop('precipitation_inches', axis=1)
	weather['date'] = pd.to_datetime(weather['date'])

####################################################################################################
	status = pd.read_csv("~/Desktop/Looker_Project/status.csv")
	status['time'] = pd.to_datetime(status['time'])

####################################################################################################
	station = pd.read_csv("~/Desktop/Looker_Project/station.csv")
	station['installation_date'] = pd.to_datetime(station['installation_date'])
	station['city'] = station['city'].map(lambda x: x.strip())
	print('Clean up of data complete\n')

####################################################################################################
	trip.to_csv("~/Desktop/Looker_Project/sub_trip.csv", header=False)
	status.to_csv("~/Desktop/Looker_Project/sub_status.csv", header=False)
	weather.to_csv("~/Desktop/Looker_Project/sub_weather.csv", header=False)
	station.to_csv("~/Desktop/Looker_Project/sub_station.csv", header=False, index=False)

	# your_list = trip['id'].tolist()
	# print(len(your_list) == len(set(your_list)))
	# print(station['id'].tolist())


	print('Subset of data created\n')
	return

