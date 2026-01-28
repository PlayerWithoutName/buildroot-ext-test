const std = @import("std");

const protobuf = @import("proto/daemon.pb.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    defer{
        if(gpa.deinit() == std.heap.Check.leak)
            std.debug.print("GPA deinit: memory leaked", .{});
    }
    const allocator = gpa.allocator();

    const f = try std.fs.cwd().openFile("testfile", .{.mode = .read_write});

    const buf = try allocator.alloc(u8, 1024);
    defer allocator.free(buf);

    var reader = std.fs.File.Reader.init(f, buf);

    var msg = try protobuf.ExampleMessage.decode(&reader.interface, allocator);
    defer msg.deinit(allocator);

    const json = try msg.jsonEncode(.{}, allocator);
    defer allocator.free(json);

    std.debug.print("Read Message: {s}\n", .{json});
}