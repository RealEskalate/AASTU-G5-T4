"use client";

import { GroupList } from "@/components/groups/group-list";

export default function GroupsPage() {
  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4">Groups</h1>
      <GroupList />
    </div>
  );
}
