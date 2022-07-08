local Log = {}
Log.levels = {
  TRACE = 1,
  DEBUG = 2,
  INFO = 3,
  WARN = 4,
  ERROR = 5,
}
vim.tbl_add_reverse_lookup(Log.levels)

local logfile = string.format("%s/%s.log", vim.fn.stdpath "cache", "ak")

function Log:init()
  local status_ok, log = pcall(require, "structlog")
  -- No logging...
  if not status_ok then
    return nil
  end

  log.configure {
    ak = {
      sinks = {
        log.sinks.Console(log.level.INFO, {
          processors = {
            log.processors.Namer(),
            log.processors.StackWriter({ "line", "file" }, { max_parents = 0, stack_level = 0 }),
            log.processors.Timestamper "%H:%M:%S",
          },
          formatter = log.formatters.FormatColorizer( --
            "%s [%s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" },
            { level = log.formatters.FormatColorizer.color_level() }
          ),
        }),
        log.sinks.NvimNotify(log.level.WARN, {
          processors = {
            log.processors.Namer(),
          },
          formatter = log.formatters.Format( --
            "%s",
            { "msg" },
            { blacklist = { "level", "logger_name" } }
          ),
          params_map = { title = "logger_name" },
        }),
        -- log.sinks.File(log.level.TRACE, "./test.log", {
        log.sinks.File(log.level.TRACE, logfile, {
          processors = {
            log.processors.Namer(),
            log.processors.StackWriter({ "line", "file" }, { max_parents = 3 }),
            log.processors.Timestamper "%H:%M:%S",
          },
          formatter = log.formatters.Format( --
            "%s [%s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" }
          ),
        }),
      },
    },
  }

  local logger = log.get_logger "ak"
  -- logger:info "A log message"
  -- logger:warn("A log message with keyword arguments", { warning = "something happened" })
  return logger
end

--- Adds a log entry using Plenary.log
---@fparam msg any
---@param level string [same as vim.log.log_levels]
function Log:add_entry(level, msg, event)
  local logger = self:get_logger()
  if not logger then
    return
  end
  logger:log(level, vim.inspect(msg), event)
end

---Retrieves the handle of the logger object
---@return table|nil logger handle if found
function Log:get_logger()
  if self.__handle then
    return self.__handle
  end

  local logger = self:init()
  if not logger then
    return
  end

  self.__handle = logger
  return logger
end

---Retrieves the path of the logfile
---@return string path of the logfile
function Log:get_path()
  return logfile
end

---Add a log entry at TRACE level
---@param msg any
---@param event any
function Log:trace(msg, event)
  self:add_entry(self.levels.TRACE, msg, event)
end

---Add a log entry at DEBUG level
---@param msg any
---@param event any
function Log:debug(msg, event)
  self:add_entry(self.levels.DEBUG, msg, event)
end

---Add a log entry at INFO level
---@param msg any
---@param event any
function Log:info(msg, event)
  self:add_entry(self.levels.INFO, msg, event)
end

---Add a log entry at WARN level
---@param msg any
---@param event any
function Log:warn(msg, event)
  self:add_entry(self.levels.WARN, msg, event)
end

---Add a log entry at ERROR level
---@param msg any
---@param event any
function Log:error(msg, event)
  self:add_entry(self.levels.ERROR, msg, event)
end

-- TODO: Is this correct? Log is returned, not {}
setmetatable({}, Log)

return Log
