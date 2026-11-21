# Railway's edge reaches the app from 100.64.0.0/10 (carrier-grade NAT space), which Rails
# doesn't count as a proxy. Without this, `request.remote_ip` is the edge's address, so every
# visitor shares the sign-in, sign-up and password-reset rate limits, and sessions record the
# edge instead of the person. No real visitor has an address in this range.
# Setting the list replaces Rails' own, so the defaults (loopback, private ranges) are kept.
Rails.application.config.action_dispatch.trusted_proxies =
  ActionDispatch::RemoteIp::TRUSTED_PROXIES + [ IPAddr.new("100.64.0.0/10") ]
