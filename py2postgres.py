#!/usr/bin/python
import psycopg2 
import os

def table_creating():
    conn = psycopg2.connect(host="localhost",database="looker_project", user="postgres", password="") 
    print("Opened database successfully")

    cur = conn.cursor()

    cur.execute("""
            CREATE TABLE IF NOT EXISTS sub_station (
                    id CHAR(10) PRIMARY KEY,
                    name CHAR(80),
                    lat REAL,
                    lng REAL,
                    dock_count INTEGER,
                    city CHAR(50),
                    installation_date DATE
            );""")
    f = open(os.path.expanduser("~/Desktop/Looker_Project/sub_station.csv"))
    cur.copy_from(f, "sub_station", sep=',', null='')
    f.close()
    print('# Table station done')


    # create table sub_trip
    cur.execute("""
            CREATE TABLE IF NOT EXISTS sub_trip (
                    index BIGINT PRIMARY KEY,
                    id INTEGER,
                    duration INTEGER,
                    start_date TIMESTAMP,
                    start_station_name CHAR(50),
                    start_station_id INTEGER,
                    end_date TIMESTAMP,
                    end_station_name CHAR(50),
                    end_station_id INTEGER,
                    bike_id BIGINT,
                    subscription_type CHAR(50),
                    zip_code CHAR(50)
            );""")
    # upload csv data into table
    f = open(os.path.expanduser("~/Desktop/Looker_Project/sub_trip.csv"))
    # doc = f.readlines()
    cur.copy_from(f, "sub_trip", sep=',', null='')
    f.close()
    print('## Table trip done')


    # create table sub_status
    cur.execute("""
            CREATE TABLE IF NOT EXISTS sub_status (
                    index BIGINT,
                    station_id CHAR(10),
                    bikes_available INTEGER,
                    docks_available INTEGER,
                    status_time TIMESTAMP,
                    PRIMARY KEY (station_id, status_time)
            );""")
    f = open(os.path.expanduser("~/Desktop/Looker_Project/sub_status.csv"))
    cur.copy_from(f, "sub_status", sep=',', null='')
    f.close()
    print('### Table status done')


    # create table sub_weather
    cur.execute("""
            CREATE TABLE IF NOT EXISTS sub_weather (
                    index BIGINT PRIMARY KEY,
                    weather_date DATE,
                    max_temperature_f REAL,
                    mean_temperature_f REAL,
                    min_temperature_f REAL,
                    max_dew_point_f REAL, 
                    mean_dew_point_f REAL,
                    min_dew_point_f REAL,
                    max_humidity REAL,
                    mean_humidity REAL,
                    min_humidity REAL, 
                    max_sea_level_pressure_inches REAL,
                    mean_sea_level_pressure_inches REAL,
                    min_sea_level_pressure_inches REAL, 
                    max_visibility_miles REAL,
                    mean_visibility_miles REAL,
                    min_visibility_miles REAL,
                    max_wind_Speed_mph REAL, 
                    mean_wind_speed_mph REAL,
                    max_gust_speed_mph REAL,
                    cloud_cover REAL,
                    events CHAR(20), 
                    wind_dir_degrees REAL,
                    zip_code CHAR(50)
            );""")
    f = open(os.path.expanduser("~/Desktop/Looker_Project/sub_weather.csv"))
    cur.copy_from(f, "sub_weather", sep=',', null='')
    f.close()
    print('#### Table weather done')

    cur.close()

    conn.commit()
    conn.close()

    return

