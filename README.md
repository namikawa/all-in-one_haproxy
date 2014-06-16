All-In-One HAProxy Chef Cookbook
================================

2台でのHA構成を想定したHAProxyサーバを作るためのChef Cookbook。

以下が本Cookbook反映後に期待できるサーバの稼働状態。

- rsync + lsyncdの稼働 (各種設定ファイルの同期)
- keepalivedの稼働 (HAクラスタ構成の実現)
- HAProxyの稼働 (LB/ReverseProxyソフトウェア)
- iptables/ip6tablesの稼働 (接続元の限定)
- Quaggaの稼働 (エッジルータ等との動的経路広報の実現)
- snmpdの稼働 (各種メトリクスの取得)
- swap領域の調整
- その他kernelパラメータの調整

Requirements / Notice
---------------------

- RHEL/CentOS 6系に対応
- IPv4/IPv6へのDual Stack対応
- 残念なことに、他Cookbookとの共存はあまり意識していません
    - できる限り、本Cookbook単体でお使いください
    - 依存している外部Cookbookは無くし、本Cookbook単体で完結する作りにしています

Usage
-----

Chef-solo(knife-solo)から実行できます。(Chef-serverに本Cookbbokを登録してお使い頂いても、もちろんOKです)

(`solo.rb`等の) `cookbook_path`にcookbookが配置されている前提で、以下のような感じで実行してみてください。

    $ sudo chef-solo -c (solo.rbのパス) -j (nodeのjsonのパス)

Cookbookの事前配置をせずに、手っ取り早く試したい場合は、以下のような感じでremote経由でcookbookを取得して実行してください。

(`/etc/chef/solo.rb`が配置されている前提。node.jsonはサンプル。)

    $ sudo chef-solo -j https://raw.githubusercontent.com/namikawa/all-in-one_haproxy/master/samples/solo/node.json -r https://dl.dropboxusercontent.com/u/684783/cookbooks/all-in-one_haproxy_20140411-1.tar.gz

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

(`all-in-one_haproxy::quagga`はdefaultからは外してあります。)

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

`attribute/` 配下の設定ファイルで各種パラメータを設定可能です。下記のAttributeで示している要素名は任意の文字列となります。

設定を追加する場合は、以下を参考に、わかりやすい任意の文字列を設定してください。

(サンプルとなるdefaultは'mysql'のみとなっており、'mysql'向けのHAProxy設定やそれに紐づくVIP、FW等の設定が入っているイメージです。)

- `node['haproxy']['frontend']['(任意の文字列)']`
- `node['haproxy']['backend']['(任意の文字列)']`
- `node['keepalived']['virtual_ipaddress']['(任意の文字列)']`
- `node['iptables']['allow']['src']['(任意の文字列)']`
- `node['ip6tables']['allow']['src']['(任意の文字列)']`


#### HAProxyでSSLの利用

HAProxyのfrontend部分のAttributeを設定することにより使えます。

例えば、SSLでHTTPS(443)を利用する場合のサンプルは以下です。

```ruby
node['haproxy']['frontend']['(任意の文字列)']['bind_port'] = "443"
node['haproxy']['frontend']['(任意の文字列)']['bind_option'] = "ssl crt /etc/haproxy/server.pem"
node['haproxy']['frontend']['(任意の文字列)']['mode'] = "http"
node['haproxy']['ssl_key'] = <<"EOS"
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAK.....

.....省略.....

EOS
```

#### HAクラスタ構成(2台)での利用

HAクラスタを構成すべき2台とも同じCookbookで構築できますが、少なくとも以下のAttributeを、2台それぞれで変更する必要があります。

- `node['keepalived']['peer']`
     - HAクラスタで対向となるサーバのIPアドレスを入力します

(通常、基本的には、上記以外のAttributeを変更する必要はありません。)

