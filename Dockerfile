# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2021 Avinal Kumar <avinal.xlvii@gmail.com>
#
# Distributed under the terms of MIT License
# The full license is in the file LICENSE, distributed with this software.

FROM ghcr.io/avinal/lark:1.0.0

# Add files to docker
ADD main.py entrypoint.sh colors.json /

# run final script
CMD python3 /main.py && /entrypoint.sh
