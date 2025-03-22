{
    "log": {
        "level": "info",
        "output": "sing-box.log",
        "timestamp": true
    },
    "dns": {
        "servers": [
            {
                "type": "https",
                "tag": "novaxns",
                "detour": "direct",
                "server": "8.217.246.48",
                "server_port": 5443,
                "path": "@meow_is_top1/dns-query"
            },
            {
                "type": "udp",
                "tag": "tencent",
                "server": "119.29.29.29",
                "server_port": 53
            },
            {
                "type": "fakeip",
                "tag": "fakeip",
                "inet4_range": "198.18.0.0/15"
            }
        ],
        "rules": [
            {
                "query_type": "HTTPS",
                "action": "reject"
            },
            {
                "domain": [
                    "cinema.makima.online",
                    "theater.makima.online",
                    "anime.makima.online",
                    "celluloid.makima.online",
                    "restrict.makima.online"
                ],
                "server": "tencent"
            },
            {
                "query_type": "A",
                "server": "fakeip",
                "rewrite_ttl": 0
            }
        ],
        "strategy": "ipv4_only",
        "independent_cache": true
    },
    "inbounds": [
        {
            "type": "socks",
            "tag": "sing-socks",
            "listen": "127.0.0.1",
            "listen_port": 65535
        },
        {
            "type": "tun",
            "tag": "sing-tun",
            "address": "172.19.0.0/30",
            "auto_route": true,
            "strict_route": true
        }
    ],
    "outbounds": [
        {
            "type": "selector",
            "tag": "proxy",
            "outbounds": [
                "direct"
            ],
            "interrupt_exist_connections": true
        },
        {
            "type": "selector",
            "tag": "telegram",
            "outbounds": [
                "direct"
            ],
            "interrupt_exist_connections": true
        },
        {
            "type": "selector",
            "tag": "apple",
            "outbounds": [
                "direct",
                "proxy"
            ],
            "interrupt_exist_connections": true
        },
        {
            "type": "selector",
            "tag": "pilipili",
            "outbounds": [
                "direct",
                "proxy"
            ],
            "interrupt_exist_connections": true
        },
        {
            "type": "selector",
            "tag": "jms",
            "outbounds": [
                "direct",
                "proxy"
            ],
            "interrupt_exist_connections": true
        },
        {
            "type": "selector",
            "tag": "結束バンド",
            "outbounds": [
                "direct",
                "proxy"
            ],
            "interrupt_exist_connections": true
        },
        {
            "type": "selector",
            "tag": "final",
            "outbounds": [
                "direct",
                "proxy"
            ],
            "interrupt_exist_connections": true
        },
        {
            "type": "direct",
            "tag": "direct"
        }
    ],
    "route": {
        "rules": [
            {
                "type": "logical",
                "mode": "or",
                "rules": [
                    {
                        "port": 53
                    },
                    {
                        "protocol": "dns"
                    }
                ],
                "action": "hijack-dns"
            },
            {
                "network": "udp",
                "port": 443,
                "action": "reject"
            },
            {
                "inbound": "sing-socks",
                "rule_set": "telegram",
                "outbound": "telegram"
            },
            {
                "rule_set": "httpdns",
                "action": "reject"
            },
            {
                "rule_set": "dns",
                "action": "reject"
            },
            {
                "rule_set": "hw",
                "action": "reject"
            },
            {
                "domain": "emby-direct.pilipiliultra.com",
                "outbound": "pilipili"
            },
            {
                "domain": "vision.recmata.net",
                "outbound": "jms"
            },
            {
                "domain": "kessoku-bando.biliblili.uk",
                "outbound": "結束バンド"
            },
            {
                "domain": [
                    "https://cinema.makima.online",
                    "https://theater.makima.online",
                    "https://anime.makima.online",
                    "https://celluloid.makima.online",
                    "https://restrict.makima.online"
                ],
                "outbound": "direct"
            },
            {
                "domain": [
                    "deepseek.com",
                    "platform.deepseek.com"
                ],
                "outbound": "direct"
            },
            {
                "domain": "ecs-api.xns.one",
                "outbound": "direct"
            },
            {
                "rule_set": "apple",
                "outbound": "apple"
            },
            {
                "rule_set": "gfw",
                "outbound": "proxy"
            },
            {
                "rule_set": "geolocation-!cn",
                "outbound": "proxy"
            },
            {
                "ip_is_private": true,
                "outbound": "direct"
            },
            {
                "rule_set": "cn",
                "outbound": "direct"
            }
        ],
        "rule_set": [
            {
                "type": "remote",
                "tag": "cn",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/Loyalsoldier/geoip/raw/refs/heads/release/srs/cn.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "apple",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/CHIZI-0618/v2ray-rules-dat/raw/refs/heads/release/singbox_rule_set/geosite-apple.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "gfw",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/CHIZI-0618/v2ray-rules-dat/raw/refs/heads/release/singbox_rule_set/geosite-gfw.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "geolocation-!cn",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/CHIZI-0618/v2ray-rules-dat/raw/refs/heads/release/singbox_rule_set/geosite-geolocation-!cn.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "telegram",
                "format": "source",
                "url": "https://githubsg.lilyya.top/https://raw.githubusercontent.com/Meow7575/repository/refs/heads/main/telegram.json",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "httpdns",
                "format": "source",
                "url": "https://githubsg.lilyya.top/https://raw.githubusercontent.com/Meow7575/repository/refs/heads/main/httpdns.json",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "dns",
                "format": "source",
                "url": "https://githubsg.lilyya.top/https://raw.githubusercontent.com/Meow7575/repository/refs/heads/main/dns.json",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "hw",
                "format": "source",
                "url": "https://githubsg.lilyya.top/https://raw.githubusercontent.com/Meow7575/repository/refs/heads/main/hw.json",
                "download_detour": "direct"
            }
        ],
        "final": "final",
        "auto_detect_interface": true,
        "default_domain_resolver": "novaxns"
    },
    "experimental": {
        "cache_file": {
            "enabled": true
        },
        "clash_api": {
            "external_controller": "127.0.0.1:9090",
            "external_ui": "sing-dashboard",
            "external_ui_download_url": "https://githubsg.lilyya.top/https://github.com/Zephyruso/zashboard/releases/latest/download/dist.zip",
            "external_ui_download_detour": "direct"
        }
    }
}
