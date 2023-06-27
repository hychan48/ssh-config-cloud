# Highlights

find /home -name "androidStreaming*.qcow2" -type f -printf "%T@ %p\n" | sort -nr | head -5 | cut -d" " -f2-

# Raw Dump
* [Manual Page](https://man.openbsd.org/ssh_config#PATTERNS)
```bash
PATTERNS
A pattern consists of zero or more non-whitespace characters, ‘*’ (a wildcard that matches zero or more characters), or ‘?’ (a wildcard that matches exactly one character). For example, to specify a set of declarations for any host in the ".co.uk" set of domains, the following pattern could be used:

Host *.co.uk
The following pattern would match any host in the 192.168.0.[0-9] network range:

Host 192.168.0.?
A pattern-list is a comma-separated list of patterns. Patterns within pattern-lists may be negated by preceding them with an exclamation mark (‘!’). For example, to allow a key to be used from anywhere within an organization except from the "dialup" pool, the following entry (in authorized_keys) could be used:

from="!*.dialup.example.com,*.example.com"
Note that a negated match will never produce a positive result by itself. For example, attempting to match "host3" against the following pattern-list will fail:

from="!host1,!host2"
The solution here is to include a term that will yield a positive match, such as a wildcard:

from="!host1,!host2,*"
TOKENS
Arguments to some keywords can make use of tokens, which are expanded at runtime:

%%
A literal ‘%’.
%C
Hash of %l%h%p%r.
%d
Local user's home directory.
%f
The fingerprint of the server's host key.
%H
The known_hosts hostname or address that is being searched for.
%h
The remote hostname.
%I
A string describing the reason for a KnownHostsCommand execution: either ADDRESS when looking up a host by address (only when CheckHostIP is enabled), HOSTNAME when searching by hostname, or ORDER when preparing the host key algorithm preference list to use for the destination host.
%i
The local user ID.
%K
The base64 encoded host key.
%k
The host key alias if specified, otherwise the original remote hostname given on the command line.
%L
The local hostname.
%l
The local hostname, including the domain name.
%n
The original remote hostname, as given on the command line.
%p
The remote port.
%r
The remote username.
%T
The local tun(4) or tap(4) network interface assigned if tunnel forwarding was requested, or "NONE" otherwise.
%t
The type of the server host key, e.g. ssh-ed25519.
%u
The local username.
CertificateFile, ControlPath, IdentityAgent, IdentityFile, KnownHostsCommand, LocalForward, Match exec, RemoteCommand, RemoteForward, RevokedHostKeys, and UserKnownHostsFile accept the tokens %%, %C, %d, %h, %i, %k, %L, %l, %n, %p, %r, and %u.

KnownHostsCommand additionally accepts the tokens %f, %H, %I, %K and %t.

Hostname accepts the tokens %% and %h.

LocalCommand accepts all tokens.

ProxyCommand and ProxyJump accept the tokens %%, %h, %n, %p, and %r.
```