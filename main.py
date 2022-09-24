# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2021 Avinal Kumar <avinal.xlvii@gmail.com>
#
# Distributed under the terms of MIT License
# The full license is in the file LICENSE, distributed with this software.

import datetime
import json
import os
import random
import sys

import matplotlib.pyplot as plt
import numpy as np
import requests

waka_key = os.getenv("INPUT_WAKATIME_API_KEY")
stats_range = os.getenv("INPUT_STATS_RANGE", "last_7_days")

def this_range(dates: list) -> str:
    """Returns streak within given range"""
    range_end = datetime.datetime.strptime(dates[4], "%Y-%m-%dT%H:%M:%SZ")
    range_start = datetime.datetime.strptime(dates[3], "%Y-%m-%dT%H:%M:%SZ")
    print("range header created")
    return f"From {range_start.strftime('%d %B, %Y')} to {range_end.strftime('%d %B, %Y')}: {dates[5]}"


def make_graph(data: list):
    """Make progress graph from API graph"""
    fig, ax = plt.subplots(figsize=(10, 2))
    with open("/colors.json") as json_file:
        color_data = json.load(json_file)
    y_pos = np.arange(len(data[0]))
    bars = ax.barh(y_pos, data[2])
    ax.set_yticks(y_pos)
    ax.get_xaxis().set_ticks([])
    ax.set_yticklabels(data[0], color="#586069")
    ax.set_title(this_range(data), color="#586069")
    ax.invert_yaxis()
    plt.box(False)
    for i, bar in enumerate(bars):
        if data[0][i] in color_data:
            bar.set_color(color_data[data[0][i]]["color"])
        else:
            bar.set_color(
                "#" + "".join([random.choice("0123456789ABCDEF")
                               for j in range(6)])
            )
        x_value = bar.get_width()
        y_values = bar.get_y() + bar.get_height() / 2
        plt.annotate(
            data[1][i],
            (x_value, y_values),
            xytext=(4, 0),
            textcoords="offset points",
            va="center",
            ha="left",
            color="#586069"
        )
    plt.savefig("stat.svg", bbox_inches="tight", transparent=True)
    print("new image generated")


def get_stats() -> list:
    """Gets API data and returns markdown progress"""
    data = requests.get(
        f"https://wakatime.com/api/v1/users/current/stats/{stats_range}?api_key={waka_key}"
    ).json()

    try:
        lang_data = data["data"]["languages"]
        start_date = data["data"]["start"]
        end_date = data["data"]["end"]
        range_total = data["data"]["human_readable_total_including_other_language"]
    except KeyError:
        print("error: please add your WakaTime API key to the Repository Secrets")
        sys.exit(1)

    lang_list = []
    time_list = []
    percent_list = []

    for lang in lang_data[:5]:
        lang_list.append(lang["name"])
        time_list.append(lang["text"])
        percent_list.append(lang["percent"])
    data_list = [lang_list, time_list, percent_list,
                 start_date, end_date, range_total]
    print("coding data collected")
    return data_list


if __name__ == "__main__":
    waka_stat = get_stats()
    make_graph(waka_stat)
    print("python script run successful")
