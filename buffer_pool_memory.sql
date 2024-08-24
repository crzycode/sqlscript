select * from ajio

SELECT physical_memory_in_use_kb/1024 [Physical Memory Used in MB],
process_physical_memory_low [Physical Memory Low],
process_virtual_memory_low [Virtual Memory Low]
FROM sys.dm_os_process_memory;