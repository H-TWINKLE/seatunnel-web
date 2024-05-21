/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.seatunnel.datasource.plugin.udp;

import org.apache.seatunnel.api.configuration.Option;
import org.apache.seatunnel.api.configuration.Options;
import org.apache.seatunnel.api.configuration.util.OptionRule;

public class UdpOptionRule {

    public static final Option<String> HOST =
            Options.key("host").stringType().defaultValue("0.0.0.0").withDescription("udp IP地址，默认是 0.0.0.0");

    public static final Option<Integer> PORT =
            Options.key("port").intType().defaultValue(9999).withDescription("udp 监听端口，默认是9999");

    public static final Option<String> TYPE =
            Options.key("type").stringType().defaultValue("UDP_TEXT").withDescription("udp 包的数据类型，默认是UDP_TEXT，可选填 UDP_BYTE ,即接收到的数据类型为byte[] 数组");

    public static final Option<String> CHARSET =
            Options.key("charset").stringType().defaultValue("UTF-8").withDescription("udp 包的数据为字符串类型时编码格式，默认是UTF-8");

    public static OptionRule optionRule() {
        return OptionRule.builder().required(HOST, PORT, TYPE).optional(CHARSET).build();
    }

    public static OptionRule metadataRule() {
        return OptionRule.builder().build();
    }
}
