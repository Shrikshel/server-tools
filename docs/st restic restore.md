# st restic restore

Restore from Restic Snapshot. Pass snapshot ID and target directory.

| Attributes       | &nbsp;
|------------------|-------------
| Alias:           | rst

## Usage

```bash
st restic restore [SNAPSHOT] [TARGET]
```

## Examples

```bash
st restic restore 12345678 /path/to/restore
```

```bash
st rs restore 12345678 /path/to/restore
```

```bash
st rs rst 12345678 /path/to/restore
```

## Arguments

#### *SNAPSHOT*

Snapshot ID to restore from

#### *TARGET*

Target directory to restore to


