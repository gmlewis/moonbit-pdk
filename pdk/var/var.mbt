/// `get_memory` returns the (unprocessed) host Memory block for the "var" data associated with
/// the provided `key`.
pub fn get_memory(key : String) -> @memory.Memory? {
  let mem = @memory.allocate_string(key)
  let offset = @pdk.extism_var_get(mem.offset)
  if offset == 0L {
    return None
  }
  let length = @pdk.extism_length(offset)
  if length == 0L {
    return None
  }
  Some({ offset, length })
}

/// `get_bytes` returns the (unprocessed) host Memory block for the "var" data associated with
/// the provided `key`.
pub fn get_bytes(key : String) -> Bytes? {
  match get_memory(key) {
    Some(v) => Some(v.to_bytes())
    None => None
  }
}

/// `get_int` returns the host's "var" Int associated with the provided `key`.
pub fn get_int(key : String) -> Int? {
  match get_memory(key) {
    Some(v) => Some(v.to_int())
    None => None
  }
}

/// `get_string` returns the host's "var" String associated with the provided `key`.
/// Note that the Extism host string is in UTF-8 and the string is converted to
/// a MoonBit (UTF-16) String.
pub fn get_string(key : String) -> String? {
  match get_memory(key) {
    Some(v) => Some(v.to_string())
    None => None
  }
}

/// `set_bytes` sets the (unprocessed) host Memory block for the "var" data associated with
/// the provided `key`.
pub fn set_bytes(key : String, value : Bytes) -> Unit {
  let keyMem = @memory.allocate_string(key)
  let valMem = @memory.allocate_bytes(value)
  @pdk.extism_var_set(keyMem.offset, valMem.offset)
}

/// `set_int` sets the host's "var" Int associated with the provided `key`.
pub fn set_int(key : String, value : Int) -> Unit {
  let keyMem = @memory.allocate_string(key)
  let bytes = Bytes::make(4)
  bytes[0] = value.land(255).to_byte()
  bytes[1] = value.lsr(8).land(255).to_byte()
  bytes[2] = value.lsr(16).land(255).to_byte()
  bytes[3] = value.lsr(24).land(255).to_byte()
  let valMem = @memory.allocate_bytes(bytes)
  @pdk.extism_var_set(keyMem.offset, valMem.offset)
}

/// `remove` deletes the value in the host's "var" memory associated with the provided `key`.
pub fn remove(key : String) -> Unit {
  let mem = @memory.allocate_string(key)
  @pdk.extism_var_set(mem.offset, 0L)
}