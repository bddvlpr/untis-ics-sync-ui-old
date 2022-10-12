<script lang="ts">
	import '../app.pcss';

	import NavBar from '../components/navigation/NavBar.svelte';
	import NavBarBrand from '../components/navigation/NavBarBrand.svelte';
	import NavBarItems from '../components/navigation/NavBarItems.svelte';
	import NavBarItem from '../components/navigation/NavBarItem.svelte';
</script>

<NavBar>
	<NavBarBrand>⏰ Untis ICS Sync</NavBarBrand>
	<NavBarItems>
		<NavBarItem href="https://github.com/bddvlpr/untis-ics-sync">GitHub</NavBarItem>
	</NavBarItems>
</NavBar>
<slot />
