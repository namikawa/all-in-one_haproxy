all-in-one_haproxy Cookbook
===========================

2台でのHA構成を想定したHAProxyサーバを作るためのChef Cookbook。

以下が処理概要。

- rsync + lsyncdの導入 (各種設定ファイルの同期)
- keepalivedの導入 (HAクラスタ構成の実現)
- HAProxyの導入 (LB/ReverseProxyソフトウェア)
- iptables/ip6tablesの設定 (接続元の限定)
- snmpdの設定と起動
- swap領域の作成
- その他kernelパラメータの調整

Requirements / Notice
---------------------

- RHEL/CentOS 6系に対応
- IPv4/IPv6/Dual Stack対応
- 残念なことに、他Cookbookとの共存はあまり意識していません
    - できる限り、本Cookbook単体でお使いください

Usage
-----

Chef-solo(knife-solo)から実行できます。(Chef-serverに本Cookbbokを登録してお使い頂いても、もちろんOKです)

(`solo.rb`等の) `cookbook_path`にcookbookが配置されている前提で、以下のような感じで実行してみてください。

    $ sudo chef-solo -c (solo.rbのパス) -j (nodeのjsonのパス)

Cookbookの事前配置をせずに、手っ取り早く試したい場合は、以下のような感じでremote経由でcookbookを取得して実行してください。

(`/etc/chef/solo.rb`が配置されている前提。node.jsonはサンプル。)

    $ sudo chef-solo -j https://raw.github.com/namikawa/chef-cookbooks/master/all-in-one_haproxy/samples/solo/node.json -r https://dl.dropboxusercontent.com/u/684783/cookbooks/all-in-one_haproxy_20140221-1.tar.gz

#### Recipes

`all-in-one_haproxy::default`Recipeを指定すると、以下Recipeが全部入りで導入されます。

- `all-in-one_haproxy::base`
- `all-in-one_haproxy::snmpd`
- `all-in-one_haproxy::mkswap`
- `all-in-one_haproxy::lsyncd`
- `all-in-one_haproxy::haproxy`
- `all-in-one_haproxy::keepalived`
- `all-in-one_haproxy::iptables`

全て必要ない場合は、必要に応じて`run_list`等で、必要なRecipeを指定してください。

#### node.jsonのsample

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

#### Attribute

`attribute/default.rb` で各種パラメータを設定可能です。下記のAttributeで示している要素名は任意の文字列となります。

設定を追加する場合は、以下を参考に、わかりやすい任意の文字列を設定してください。

(サンプルとなるdefaultは'mysql'のみとなっており、'mysql'向けのHAProxy設定やそれに紐づくVIP、FW等の設定が入っているイメージです。)

- `node['haproxy']['frontend']['(任意の文字列)']`
- `node['haproxy']['backend']['(任意の文字列)']`
- `node['keepalived']['virtual_ipaddress']['(任意の文字列)']`
- `node['iptables']['allow']['src']['(任意の文字列)']`
- `node['ip6tables']['allow']['src']['(任意の文字列)']`


#### HAクラスタ構成(2台)での利用

HAクラスタを構成すべき2台とも同じCookbookで構築できますが、少なくとも以下のAttributeを、2台それぞれで変更する必要があります。

- `node['keepalived']['peer']`
     - HAクラスタで対向となるサーバのIPアドレスを入力します

(通常、基本的には、上記以外のAttributeを変更する必要はありません。)

