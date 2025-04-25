"use client";

import { GroupCard } from "@/components/groups/group-card";
import { useGetGroupsQuery } from "@/lib/redux/api/groupApiSlice";

export function GroupList() {
  const { data: groups = [], isLoading, isError } = useGetGroupsQuery();

  console.log("Fetched groups data:", groups); // Log the fetched groups data

  if (isLoading) return <p>Loading...</p>;
  if (isError) return <p>Error loading groups.</p>;

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 w-full">
      {groups.map((group) => (
        <GroupCard key={group.id} group={group} />
      ))}
    </div>
  );
}
