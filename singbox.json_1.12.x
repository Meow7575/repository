{
    "log": {
        "level": "info",
        "output": "box.log",
        "timestamp": true
    },
    "dns": {
        "servers": [
            {
                "type": "https",
                "tag": "local",
                "server": "106.75.164.170",
                "path": "Eaf9nie7quee/endusers",
                "detour": "direct"
            },
            {
                "type": "fakeip",
                "tag": "fakeip",
                "inet4_range": "198.18.0.0/15",
                "inet6_range": "fc00::/18"
            }
        ],
        "rules": [
            {
                "query_type": "HTTPS",
                "action": "reject",
                "method": "default"
            },
            {
                "query_type": "AAAA",
                "action": "reject",
                "method": "default"
            },
            {
                "rule_set": "fake-ip-filter",
                "server": "local"
            },
            {
                "query_type": [
                    "A",
                    "AAAA"
                ],
                "server": "fakeip",
                "rewrite_ttl": 0
            }
        ],
        "fakeip": {
            "enabled": true,
            "inet4_range": "198.18.0.0/15",
            "inet6_range": "fc00::/18"
        },
        "independent_cache": true
    },
    "inbounds": [
        {
            "type": "tun",
            "mtu": 65535,
            "address": [
                "172.19.0.0/30",
                "fdfe:dcba:9876::/126"
            ],
            "auto_route": true,
            "strict_route": true,
            "stack": "gvisor"
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
                "direct"
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
                "action": "reject",
                "method": "default"
            },
            {
                "rule_set": "telegram",
                "outbound": "telegram"
            },
            {
                "action": "sniff",
                "sniffer": [
                    "tls",
                    "http",
                    "quic"
                ],
                "timeout": "40ms"
            },
            {
                "rule_set": "httpdns",
                "action": "reject",
                "method": "default"
            },
            {
                "rule_set": "AWAvenue-Ads-Rule-Singbox-regex",
                "action": "reject",
                "method": "default"
            },
            {
                "rule_set": "spotify",
                "outbound": "spotify"
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
                "rule_set": "private",
                "outbound": "direct"
            },
            {
                "rule_set": "cn",
                "outbound": "direct"
            },
            {
                "domain": "emby-direct.pilipiliultra.com",
                "outbound": "proxy"
            }
        ],
        "rule_set": [
            {
                "type": "remote",
                "tag": "private",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/MetaCubeX/meta-rules-dat/raw/refs/heads/sing/geo/geoip/private.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "cn",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/MetaCubeX/meta-rules-dat/raw/refs/heads/sing/geo/geoip/cn.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "spotify",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/MetaCubeX/meta-rules-dat/raw/refs/heads/sing/geo/geosite/spotify.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "gfw",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/MetaCubeX/meta-rules-dat/raw/refs/heads/sing/geo/geosite/gfw.srs",
                "download_detour": "direct"
            },
            {
                "type": "remote",
                "tag": "geolocation-!cn",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/MetaCubeX/meta-rules-dat/raw/refs/heads/sing/geo/geosite/geolocation-!cn.srs",
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
                "tag": "fake-ip-filter",
                "format": "binary",
                "url": "https://githubsg.lilyya.top/https://github.com/DustinWin/ruleset_geodata/raw/refs/heads/sing-box-ruleset/fakeip-filter.srs",
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
        "default_domain_resolver": "local"
    },
    "experimental": {
        "cache_file": {
            "enabled": true
        },
        "clash_api": {
            "external_controller": "127.0.0.1:9090",
            "external_ui": "dashboard",
            "external_ui_download_url": "https://githubsg.lilyya.top/https://github.com/Zephyruso/zashboard/releases/latest/download/dist.zip",
            "external_ui_download_detour": "direct"
        }
    }
}
