//
//  CryptoSwift
//
//  Copyright (C) 2014-2022 Marcin Krzyżanowski <marcin@krzyzanowskim.com>
//  This software is provided 'as-is', without any express or implied warranty.
//
//  In no event will the authors be held liable for any damages arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
//
//  - The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation is required.
//  - Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
//  - This notice may not be removed or altered from any source or binary distribution.
//
<<<<<<< HEAD

/** Protocol and extensions for integerFrom(bits:). Bit hakish for me, but I can't do it in any other way */
protocol Initiable {
    init(_ v: Int)
    init(_ v: UInt)
}

extension Int: Initiable {}
extension UInt: Initiable {}
extension UInt8: Initiable {}
extension UInt16: Initiable {}
extension UInt32: Initiable {}
extension UInt64: Initiable {}

/** build bit pattern from array of bits */
@_specialize(UInt)
@_specialize(UInt8)
//@_specialize(UInt16)
//@_specialize(UInt32)
//@_specialize(UInt64)
func integerFrom<T: UnsignedInteger>(_ bits: Array<Bit>) -> T {
    var bitPattern: T = 0
    for idx in bits.indices {
        if bits[idx] == Bit.one {
            let bit = T(UIntMax(1) << UIntMax(idx))
            bitPattern = bitPattern | bit
        }
    }
    return bitPattern
}
=======
>>>>>>> main

/// Array of bytes. Caution: don't use directly because generic is slow.
///
/// - parameter value: integer value
/// - parameter length: length of output array. By default size of value type
///
/// - returns: Array of bytes
<<<<<<< HEAD
//@_specialize(Int)
//@_specialize(UInt)
//@_specialize(UInt8)
//@_specialize(UInt16)
//@_specialize(UInt64)
@_specialize(UInt32)
func arrayOfBytes<T: Integer>(value: T, length totalBytes: Int = MemoryLayout<T>.size) -> Array<UInt8> {
    let valuePointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
    valuePointer.pointee = value
=======
@_specialize(where T == Int)
@_specialize(where T == UInt)
@_specialize(where T == UInt8)
@_specialize(where T == UInt16)
@_specialize(where T == UInt32)
@_specialize(where T == UInt64)
@inlinable
func arrayOfBytes<T: FixedWidthInteger>(value: T, length totalBytes: Int = MemoryLayout<T>.size) -> Array<UInt8> {
  let valuePointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
  valuePointer.pointee = value
>>>>>>> main

  let bytesPointer = UnsafeMutablePointer<UInt8>(OpaquePointer(valuePointer))
  var bytes = Array<UInt8>(repeating: 0, count: totalBytes)
  for j in 0..<min(MemoryLayout<T>.size, totalBytes) {
    bytes[totalBytes - 1 - j] = (bytesPointer + j).pointee
  }

  valuePointer.deinitialize(count: 1)
  valuePointer.deallocate()

  return bytes
}
