local M = {}

-- Launch a graphical application as its own systemd unit/scope.
-- Keeping apps out of the compositor's unit lets them be managed and
-- cleaned up independently by systemd (the uwsm-recommended way).
function M.app(cmd)
	return "uwsm app -- " .. cmd
end

-- Launch a session daemon in session-graphical.slice.
function M.session(cmd)
	return "uwsm app -s s -- " .. cmd
end

return M
