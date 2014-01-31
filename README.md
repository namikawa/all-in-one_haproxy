all-in-one_haproxy Cookbook
===========================

2台でのHA構成を想定したHAProxyサーバを作るためのChef Cookbook。
以下が処理概要。

- rsync + lsyncdの導入 (設定ファイルの同期)
- keepalivedの導入 (HAクラスタ)
- HAProxyの導入 (LB/ReverseProxy)
- iptables/ip6tablesの設定 (接続元の限定)
- swapの作成
- その他kernelパラメータの調整


Requirements
------------

- RHEL/CentOS6系に対応
- IPv4/IPv6両対応
- 残念なことに、他Cookbookとの共存はあまり意識していません


Usage
-----

Chef-solo(knife-solo)から実行できます。(Chef-serverに登録してももちろんOK)
cookbook_pathにcookbookが配置されている前提で、以下のような感じで実行してみてください。

    $ sudo chef-solo -c (solo.rbのパス) -j (nodeのjsonのパス)

手っ取り早く試したい場合は、remote経由でcookbookを取得して実行してください。
(/etc/chef/solo.rbが配置されている前提。node.jsonはサンプル。)

    $ sudo chef-solo -j https://raw.github.com/namikawa/chef-cookbooks/master/all-in-one_haproxy/samples/solo/node.json -r https://dl.dropboxusercontent.com/u/684783/cookbooks/all-in-one_haproxy_20140130-01.tar.gz

e.g.
Just include `all-in-one_haproxy` in your node's `run_list`:

```json
{
  "name":"lb01",
  "run_list": "recipe[all-in-one_haproxy]",
  "haproxy": {
    "nbproc": "4",
    "backend": {
      "mysql": {"server": [
        "db001 db001.example.com:3306 weight 10 check port 3306 inter 5000 fall 3",
        "db002 db002.example.com:3306 weight 10 check port 3306 inter 5000 fall 3"
      ]}
    }
  },
  "keepalived": {
    "peer": "192.168.110.112",
    "virtual_ipaddress": {"mysql": ["192.168.110.211"]},
    "auth_pass": "3T1zlFZz"
  },
  "iptables": {"allow": {"src": {
    "mysql": {"address": [
      "192.168.110.31/32",
      "192.168.111.31/32"
    ]}
  }}},
  "ip6tables": ""
}
```

#### HA構成(2台)での利用

2台とも同じCookbookで構築できますが、少なくとも以下のAttributeを2台それぞれで変更する必要があります。

- `node['keepalived']['peer']`
-- HAクラスタで対向となるサーバのIPアドレスを入力します

