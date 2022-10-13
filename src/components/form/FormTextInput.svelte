<script lang="ts">
	export let id: string;
	export let value = '';
	export let label: string;
	export let disabled = false;
	export let readonly = false;
</script>

<label for={id} class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-400"
	>{label}</label
>
<input
	type="text"
	{id}
	class="rounded-lg bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
	{value}
	{disabled}
	{readonly}
/>
