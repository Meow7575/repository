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
            "tag": "spotify",
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
                "rule_set": "AWAvenue-Ads-Rule-Singbox-regex",
                "action": "reject"
            },
            {
                "rule_set": "spotify",
                "outbound": "spotify"
            },
            {
                "inbound": "sing-tun",
                "rule_set": [
                    "gfw",
                    "geolocation-!cn"
                ],
                "action": "sniff",
                "sniffer": [
                    "http",
                    "tls"
                ]
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
                    "deepseek.com",
                    "platform.deepseek.com"
                ],
                "outbound": "direct"
            },
            {
                "domain": "ecs-api.xns.one",
                "outbound": "direct"
            }
        ],
        "rule_set": [
            {
                "type": "remote",
                "tag": "cn",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/SagerNet/sing-geoip/raw/refs/heads/rule-set/geoip-cn.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "spotify",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/SagerNet/sing-geosite/raw/refs/heads/rule-set/geosite-spotify.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "gfw",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/SagerNet/sing-geosite/raw/refs/heads/rule-set/geosite-greatfire.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "geolocation-!cn",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/SagerNet/sing-geosite/raw/refs/heads/rule-set/geosite-geolocation-!cn.srs",
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
            },
            {
                "type": "remote",
                "tag": "AWAvenue-Ads-Rule-Singbox-regex",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/refs/heads/main/Filters/AWAvenue-Ads-Rule-Singbox-regex.srs",
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
